# frozen_string_literal: true

# Player class stores data about a tic-tac-toe player
class Player
  @@num_of_players = 0
  attr_reader :name

  def initialize
    @score = 0
    @@num_of_players += 1
    @player_id = @@num_of_players
    @name = grab_name
  end

  def ask_move
    puts "Where does player #{@player_id} want to move?"
    gets.chomp
  end

  private

  def grab_name
    puts "What is the name of player #{@player_id}?"
    gets.chomp
  end
end
