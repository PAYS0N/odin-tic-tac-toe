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

  def ask_move
    row = nil
    until (1..3).to_a.include?(row)
      puts "What row does #{@name} select?"
      row = gets.chomp.to_i
    end
    column = nil
    until (1..3).to_a.include?(column)
      puts "What column does #{@name} select?"
      column = gets.chomp.to_i
    end
    [row, column, @char]
  end

  def wins
    puts "#{@name} wins!"
  end

  private

  def grab_player_character
    puts "What character does #{@name} want to use?"
    char = nil
    loop do
      char = gets.chomp
      break if !char.nil? && char.length == 1

      puts "Invalid, please enter a character."
    end
    char
  end

  def grab_name
    puts "What is the name of player #{@player_id}?"
    name = nil
    loop do
      name = gets.chomp
      break unless name == ""

      puts "Please enter a name."
    end
    name
  end
end
