require_relative './lib/screen'
require_relative './lib/board'
require_relative './lib/player/human'
require_relative './lib/player/computer'
# Game class
class Game
  # Const
  MODES = [
    [0, 'Human vs Computer'],
    [1, 'Human vs Human'],
    [2, 'Computer vs Computer']
  ].freeze

  LEVELS = [
    [0, 'Easy'],
    [1, 'Normal'],
    [2, 'Hard']
  ].freeze

  attr_accessor :board,
                :screen
  attr_reader :cross,
              :nought,
              :mode

  def board
    @board ||= Board.new
  end

  def screen
    @screen ||= Screen
  end

  def players
    @players || []
  end

  def add_player(player = nil)
    players.push player
  end

  def clear_players
    @players = []
  end

  def initialize_players
    clear_players
    case mode
    when 0
      # Human vs Computer
      add_player Player::Human.new(self, nought)
      level = screen.choice LEVELS,
                          'Choose the game level:',
                          'Choose the correct game level'
      add_player Player::Computer.new(self, cross, level)
    when 1
      # Human vs Human
      add_player Player::Human.new(self, nought)
      add_player Player::Human.new(self, cross)
    else
      # Computer vs Computer
      add_player Player::Computer.new(self, nought)
      add_player Player::Computer.new(self, cross)
    end
  end

  def start
    screen.clear
    set_mode
    initialize_players
    # loop through until the game was won or tied
    until game_is_over? || tie?
      players.each do |player|
        screen.clear
        board.draw
        player.spot if !game_is_over? && !tie?
      end
    end
    screen.clear
    board.draw
    screen.message 'Game over', :error
  end

  def set_mode
    @mode = screen.choice MODES,
                          'Choose the game mode:',
                          'Choose the correct game mode'
  end

  def game_is_over?
    board.game_is_over
  end

  def tie?
    board.tie
  end

  def markers
    board.class::MARKERS
  end

  def cross
    board.class::CROSS
  end

  def nought
    board.class::NOUGHT
  end

  def opponent_marker(mkr = '-')
    return markers[0] if markers.index(mkr) > 0
    markers[1]
  end
end

game = Game.new
game.start
