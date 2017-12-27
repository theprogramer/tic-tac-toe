require_relative './base'
module Player
  # Player Human class
  class Human < Base
    def spot
      option = game.screen.choice game.board.available_options, 'Enter:', 'Error'
      game.board.options[option] = marker
    end
  end
end
