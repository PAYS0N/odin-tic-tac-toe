# frozen_string_literal: true

# Player class stores data about a tic-tac-toe player
class Player
  @@num_of_players = 0

  def initialize
    @score = 0
    @@num_of_players += 1
    @player_id = @@num_of_players
    @name = grab_name
    @char = grab_player_character
  end

  # add input validation
  def ask_move
    puts "What row does player #{@player_id} select?"
    row = gets.chomp.to_i
    puts "What column does player #{@player_id} select?"
    column = gets.chomp.to_i
    [row, column, @char]
  end

  private

  # add input validation
  def grab_player_character
    puts "What character does player #{@player_id} want to use?"
    gets.chomp
  end

  def grab_name
    puts "What is the name of player #{@player_id}?"
    gets.chomp
  end
end
