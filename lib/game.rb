require 'io/console'
require './lib/board'

class Game
  
  def initialize
    state = []
    7.times { state << [] }
    @board = Board.new(state)
  end
  
  # Answers 0-indexed column that player wants to play move to
  def get_move(possibles)
    begin
      move = STDIN.getch.to_i - 1
    end until possibles.include? move
    move
  end
  
  def print_board
    view = @board.board_view
    view.each do |l|
      puts l
    end
  end
  
  def play_game
    loop do
      print_board
      move = get_move(@board.possible_moves)
      @board.play_move(move)
      break if @board.done?
    end
    print_board
  end
  
end