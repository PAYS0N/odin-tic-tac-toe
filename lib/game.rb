# frozen_string_literal: true

# Game class stores and updates the state of a tic-tac-toe game
class Game
  def initialize(player1, player2)
    @game_state = []
    @player1 = player1
    @player2 = player2
  end

  def play_game
    play_round
  end

  private

  def play_round
    p1_move = @player1.ask_move
    update_game(p1_move)
    display
    p2_move = @player2.ask_move
    update_game(p2_move)
    display
  end

  def update_game(move)
    @game_state.push(move)
  end

  def display
    p @game_state
  end
end
