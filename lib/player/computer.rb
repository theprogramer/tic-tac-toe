require_relative './base'
module Player
  # Player Computer class
  class Computer < Base
    # AI dificult levels
    AI_HARD = 2
    AI_NORMAL = 1
    AI_EASY = 0

    attr_accessor :level

    def initialize(game = nil, mkr = '-', level = 2)
      super(game, mkr)
      @level = level
    end

    def spot
      move = case level
             when AI_HARD
               hard_move || normal_move || easy_move
             when AI_NORMAL
               normal_move || easy_move
             else
               easy_move
             end
      game.board.options[move] = marker
    end

    def hard_move
      return 4 if game.board.options[4] == '4'
    end

    def normal_move
      game.board.available_options.each do |as|
        return as if best_move?(as, marker)
        return as if best_move?(as, game.opponent_marker(marker))
      end
      nil
    end

    def easy_move
      game.board.available_options.sample
    end

    def best_move?(option = 0, mrk = '-')
      result = false
      game.board.options[option] = mrk
      result = true if game.game_is_over?
      game.board.options[option] = option
      result
    end
  end
end
