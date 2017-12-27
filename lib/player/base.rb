module Player
  class Base
    attr_reader :game
    attr_accessor :marker

    def spot
      nil
    end

    def initialize(game = nil, mkr = '-')
      @game = game
      @marker = mkr
    end
  end
end
