require_relative './base'
module Player
  class Computer < Base
    def spot
      spot = nil
      until spot
        if game.board.options[4] == "4"
          spot = 4
          game.board.options[spot] = marker
        else
          #spot = get_best_move(game.board.options, marker)
          spot = get_best_move(game.board.options, game.opponent_marker(marker))
          if game.board.options[spot] != 'X' && game.board.options[spot] != 'O'
            game.board.options[spot] = marker
          else
            spot = nil
          end
        end
      end
    end

    def get_best_move(board, next_player, depth = 0, best_score = {})
      # available_spaces = []
      best_move = nil
      # board.each do |s|
      #   if s != 'X' && s != 'O'
      #     available_spaces << s
      #   end
      # end
      game.board.available_options.each do |as|
      # available_spaces.each do |as|
        board[as] = marker
        if game.game_is_over?
          best_move = as
          board[as] = as
          return best_move
        else
          board[as] = game.opponent_marker(marker)
          if game.game_is_over?
            best_move = as
            board[as] = as
            return best_move
          else
            board[as] = as
          end
        end
      end
      if best_move
        return best_move
      else
        n = game.board.available_options.sample
        return game.board.available_options[n]
      end
    end
  end
end
