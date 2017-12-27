module Player
  class Base
    attr_reader :game

    def spot
      nil
    end

    def initialize(game = nil)
      @game = game
    end
  end
end
