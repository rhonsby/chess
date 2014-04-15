class SteppingPiece < Piece
  DELTA_KI = [[1, 1], [1, -1], [-1, 1], [0, 1], [0, -1], [-1, 0], [1, 0], [-1,-1]]
  DELTA_KN = [[1, 2], [2, 1], [-1, 2], [-2, 1], [1, -2], [2, -1], [-1, -2], [-2, -1]]

  def available_moves
    [].tap do |moves_array|
      self.deltas.each do |dx, dy|
        new_pos = [self.pos.first + dx, self.pos.last + dy]
        if in_board?(new_pos)
          piece = board[new_pos]
          moves_array << new_pos if piece.nil? || enemy?(piece)
        end
      end
    end
  end
end

class King < SteppingPiece

  def deltas
    SteppingPiece::DELTA_KI
  end

  def available_moves!
    [].tap do |moves_array|
      self.deltas.each do |dx, dy|
        new_pos = [self.pos.first + dx, self.pos.last + dy]
        if in_board?(new_pos)
          piece = board[new_pos]
          moves_array << new_pos if piece.nil? || enemy?(piece)
        end
      end
    end
  end

  def available_moves
    pre_filtered_moves = super - self.board.team_moves(other_team_color)
    pre_filtered_moves.reject do |pos|
      self.board.puts_player_in_check?(self,pos)
    end
  end

  def to_s
    self.color == :black ? "\u265A".brown : "\u2654".gray
  end
end


class Knight < SteppingPiece
  def deltas
    SteppingPiece::DELTA_KN
  end

  def to_s
    self.color == :black ? "\u265E".brown : "\u2658".gray
  end
end