require_relative 'board'
require_relative 'piece'
require_relative 'string'

class Game
  attr_accessor :board, :players

  def players
    @players ||= [:white, :black].cycle
  end

  def board
    @board ||= Board.new
  end

  def play
    begin
      current_player = self.players.next
      render

      command = prompt_user(current_player)

      starting_pos, ending_pos = command
      board.move(starting_pos, ending_pos)
    end until game_over?(current_player, ending_pos)

    render
    display_end_game_message
  end

  def display_end_game_message
    puts "Checkmate"
  end

  def render
    system('clear')

    puts " #{(0..7).to_a.join(' ')}"
    self.board.grid.each_with_index do |row, idx|
      puts "#{idx}#{row.join(' ')}"
    end
    puts
  end

  def prompt_user(color)
    while true
      print "#{color} | What piece would you like to move? "
      command = gets.chomp.split(',')

      start_pos = command.map(&:to_i)

      start_piece = self.board[start_pos]

      if start_piece.nil?
        puts "There's no piece there, asshole. Don't break the system."
        next
      end

      if start_piece.color != color
        puts "That piece is not yours."
        next
      end

      puts "Available moves: #{start_piece.available_moves}"

      print "#{color} | Where would you like to place the piece? "
      end_pos = gets.chomp.split(',').map(&:to_i)

      if self.board.valid_move?(start_pos, end_pos)
        return [start_pos, end_pos]
      else
        if self.board.in_check?(color)
          puts "Get your shit together. You're checked, mate."
        else
          puts "That piece can't go there."
        end
        next
      end
    end
  end

  def game_over?(color, ending_pos)
    other_color = color == :black ? :white : :black
    self.board.checkmate?(other_color, ending_pos) #
  end
end

Game.new.play
