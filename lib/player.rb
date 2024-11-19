# frozen_string_literal: true

# Player class stores data about a tic-tac-toe player
class Player
  def initialize
    @score = 0
  end

  def startup
    @name = grab_name
    @char = grab_player_character
  end

  def ask_move
    row = ask_row
    column = ask_column
    [row, column, @char]
  end

  def ask_row
    row = nil
    until (1..3).to_a.include?(row)
      puts "What row does #{@name} select?"
      row = gets.chomp.to_i
    end
    row
  end

  def ask_column
    column = nil
    until (1..3).to_a.include?(column)
      puts "What column does #{@name} select?"
      column = gets.chomp.to_i
    end
    column
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
    puts "What is the name of the player?"
    name = nil
    loop do
      name = gets.chomp
      break unless name == ""

      puts "Please enter a name."
    end
    name
  end
end
