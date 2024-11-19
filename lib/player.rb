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
    prompt = "What row does #{@name} select?"
    error = "Please enter 1 through 3"
    prep = ->(input) { input.chomp.to_i }
    test = ->(num) { (1..3).to_a.include?(num) }
    verify_input(prompt, error, prep, test)
  end

  def ask_column
    prompt = "What column does #{@name} select?"
    error = "Please enter 1 through 3"
    prep = ->(input) { input.chomp.to_i }
    test = ->(num) { (1..3).to_a.include?(num) }
    verify_input(prompt, error, prep, test)
  end

  def wins
    puts "#{@name} wins!"
  end

  def grab_player_character
    prompt = "What character does #{@name} want to use?"
    error = "Please enter a single character."
    prep = ->(char) { char.strip }
    test = ->(char) { !char.nil? && char.length == 1 }
    verify_input(prompt, error, prep, test)
  end

  def grab_name
    prompt = "What is the name of the player?"
    error = "Please enter a name."
    prep = ->(name) { name.strip }
    test = ->(name) { !name.empty? }
    verify_input(prompt, error, prep, test)
  end

  # pass text and a block to ask user for input that when the block returns true, the input is validated. returns valid
  # input as inputted string
  def verify_input(prompt, error_msg = "Invalid, try again.", prep_proc = ->(x) { x.chomp }, test = ->(val) { !val.empty? }) # rubocop:disable Layout/LineLength
    puts prompt
    input = prep_proc.call(gets)
    until test.call(input)
      puts error_msg
      input = prep_proc.call(gets)
    end
    input
  end
end
