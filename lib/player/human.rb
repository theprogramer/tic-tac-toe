require_relative './base'
module Player
  class Human < Base
    def spot
      option = game.screen.choice game.board.available_options, 'Enter:', 'Error'
      game.board.options[option] = game.hum
    end
  end
end
