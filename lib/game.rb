# frozen_string_literal: true

# Game class stores the state of a tic-tac-toe game
class Game
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def play_game
    play_round
  end

  private

  def play_round
    puts @player1.name
    puts @player2.name
  end
end
