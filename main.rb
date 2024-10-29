# frozen_string_literal: true

require_relative("lib/game_engine")
require_relative("lib/player")

# create two users
# create instance of game with two players
player1 = Player.new
player2 = Player.new

game = GameEngine.new(player1, player2)
game.play_game
