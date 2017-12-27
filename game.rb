require_relative './lib/screen'
require_relative './lib/board'
require_relative './lib/player/human'
require_relative './lib/player/computer'

class Game
  attr_reader :board,
              :screen,
              :hum,
              :com
  def initialize
    @board = Board.new
    @com = Board::CROSS
    @hum = Board::NOUGHT
    @screen = Screen
    @human = Player::Human.new(self)
    @computer = Player::Computer.new(self)
  end

  def start_game
    # start by printing the board
    board.draw
    # loop through until the game was won or tied
    until game_is_over? || tie?
      @human.spot
      if !game_is_over? && !tie?
        @computer.spot
      end
      screen.clear
      board.draw
    end
    screen.message 'Game over', :error
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
