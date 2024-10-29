# frozen_string_literal: true

# Player class stores data about a tic-tac-toe player
class Player
  attr_reader :name

  def initialize
    @score = 0
    @name = grab_name
  end

  def grab_name
    "grabbed name"
  end
end
