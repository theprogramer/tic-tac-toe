class Board
  attr_reader :options

  # the nought marker
  NOUGHT = 'O'.freeze
  # the cross marker
  CROSS = 'X'.freeze
  # the board options
  OPTIONS = %w(0 1 2 3 4 5 6 7 8) #.freeze
  # horizontal line
  LINE = '===+===+==='.freeze

  # Rows
  TOP = [0, 1, 2].freeze
  MIDDLE = [3, 4, 5].freeze
  BOTTOM = [6, 7, 8].freeze
  LEFT = [0, 3, 6].freeze
  CENTER = [1, 4, 7].freeze
  RIGHT = [2, 5, 8].freeze
  SLASH = [6, 4, 2].freeze
  BACKSLASH = [0, 4, 8].freeze

  def initialize
    @options = Board::OPTIONS
  end

  # Draw board
  def draw
    puts " #{@options[0]} | #{@options[1]} | #{@options[2]} \n#{Board::LINE}\n #{@options[3]} | #{@options[4]} | #{@options[5]} \n#{Board::LINE}\n #{@options[6]} | #{@options[7]} | #{@options[8]} \n"
  end

  # Check if is a row
  def row?(opt = [])
    options.values_at(*opt).uniq.length == 1
  end

  # Game is over
  def game_is_over
    row?(TOP) ||
      row?(MIDDLE) ||
      row?(BOTTOM) ||
      row?(LEFT) ||
      row?(CENTER) ||
      row?(RIGHT) ||
      row?(SLASH) ||
      row?(BACKSLASH)
  end

  # Tie
  def tie
    options.all? { |s| s == CROSS || s == NOUGHT }
  end

  # Available options
  def available_options
    options.reject { |k| k == CROSS || k == NOUGHT }
           .map(&:to_i)
  end
end
