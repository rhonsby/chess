require_relative "stepping_piece"
require_relative "sliding_piece"
require_relative "pawn"

class Piece
  attr_accessor :board, :pos, :color

  def initialize(board, pos, color)
    self.board, self.pos, self.color = board, pos, color
  end

  def available_moves
    raise NotImplementedError
  end

  def deltas
    raise NotImplementedError
  end

  def other_team_color
    self.color == :black ? :white : :black
  end

  def enemy?(enemy)
    self.color != enemy.color
  end

  def in_board?(pos)
    pos.first.between?(0,7) && pos.last.between?(0,7)
  end

  def dup(board)
    self.class.new(board, self.pos.dup, self.color)
  end
end
