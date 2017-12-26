require_relative './lib/screen'
require_relative './lib/board'

class Game
  attr_reader :board, :screen
  def initialize
    @board = Board.new
    @com = Board::CROSS
    @hum = Board::NOUGHT
    @screen = Screen
  end

  def start_game
    # start by printing the board
    board.draw
    # loop through until the game was won or tied
    until game_is_over? || tie?
      get_human_spot
      if !game_is_over? && !tie?
        eval_board
      end
      screen.clear
      board.draw
    end
    screen.message 'Game over', :error
  end

  def get_human_spot
    spot = nil
    until spot
      spot = screen.choice board.available_options, 'Enter', 'Error'
      if board.options[spot] != Board::CROSS && board.options[spot] != Board::NOUGHT
        board.options[spot] = @hum
      else
        spot = nil
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if board.options[4] == "4"
        spot = 4
        board.options[spot] = @com
      else
        spot = get_best_move(board.options, @com)
        if board.options[spot] != Board::CROSS && board.options[spot] != Board::NOUGHT
          board.options[spot] = @com
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != Board::CROSS && s != Board::NOUGHT
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over?
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over?
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def game_is_over?
    board.game_is_over
  end

  def tie?
    board.tie
  end
end

Screen::clear
game = Game.new
game.start_game
