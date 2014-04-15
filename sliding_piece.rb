class SlidingPiece < Piece
  DELTA_T = [
    [1,0],
    [0,1],
    [0,-1],
    [-1,0]
  ]

  DELTA_X = [
    [1,1],
    [1,-1],
    [-1,1],
    [-1,-1]
  ]

  def available_moves
    [].tap do |moves_array|

      self.deltas.each do |dx, dy|
        new_pos = self.pos

        obstructed = false
        until obstructed
          new_pos = [new_pos.first + dx, new_pos.last + dy]

          if in_board?(new_pos)
            piece = self.board[new_pos]

            if piece.nil?
              moves_array << new_pos
            elsif enemy?(piece)
              obstructed = true
              moves_array << new_pos
            else
              obstructed = true
            end
          else
            obstructed = true
          end
        end
      end
    end
  end
end

class Rook < SlidingPiece
  def deltas
    SlidingPiece::DELTA_T
  end

  def to_s
    self.color == :black ? "\u265C".brown : "\u2656".gray
  end
end

class Bishop < SlidingPiece
  def deltas
    SlidingPiece::DELTA_X
  end

  def to_s
    self.color == :black ? "\u265D".brown : "\u2657".gray
  end
end

class Queen < SlidingPiece
  def deltas
    SlidingPiece::DELTA_T + SlidingPiece::DELTA_X
  end

  def to_s
    self.color == :black ? "\u265B".brown : "\u2655".gray
  end
end