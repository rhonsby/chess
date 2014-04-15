
class Pawn < Piece
  attr_reader :first_move

  DELTA_B = [[1, 0], [2, 0]]
  DELTA_Y = [[1, 1], [1, -1]]

  def initialize(board, pos, color)
    super(board, pos, color)
    @first_move = true
  end

  def first_move?
    @first_move
  end

  def delta
    limit = self.first_move? ? 2 : 1
    if (self.color == :black)
      DELTA_B.take(limit)
    else
      DELTA_B.take(limit).map{ |x, y| [x * (-1), y * (-1)] }
    end
  end

  def pos=(position)
    @pos = position
    @first_move = false
  end

  def delta_y
    self.color == :black ? DELTA_Y : DELTA_Y.map do |x, y|
      [x * (-1), y * (-1)]
    end
  end

  def available_moves
    forward_moves + taking_moves
  end

  def forward_moves
    moves_array = []
    delta.each do |dx, dy|
      new_pos = [self.pos.first + dx, self.pos.last + dy]
      if in_board?(new_pos)
        piece = board[new_pos]
        if piece.nil?
          moves_array << new_pos
        else
          return moves_array
        end
      end
    end
    moves_array
  end

  def taking_moves
    [].tap do |moves_array|
      delta_y.each do |dx, dy|
        new_pos = [self.pos.first + dx, self.pos.last + dy]
        if in_board?(new_pos)
          piece = board[new_pos]
          moves_array << new_pos if !piece.nil? && enemy?(piece)
        end
      end
    end
  end

  def to_s
    self.color == :black ? "\u265F".brown : "\u2659".gray
  end
end