# frozen_string_literal: true

# Game class stores and updates the state of a tic-tac-toe game
class Game
  def initialize(player1, player2)
    @game_state = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @player1 = player1
    @player2 = player2
    @player_to_move = @player1
  end

  def play_game
    explain_game
    play_round
  end

  private

  def explain_game
    puts "On your turn, enter the row and column you want to select. For example, if\n"
    puts "you want to select the example cell below, you would enter 3 and then 2."
    display([[nil, nil, nil], [nil, nil, nil], [nil, "X", nil]])
  end

  def play_round
    player_move = @player_to_move.ask_move
    update_game(player_move)
    @player_to_move = @player_to_move == @player1 ? @player2 : @player1
    display(@game_state)
  end

  def update_game(move)
    @game_state[move[0] - 1][move[1] - 1] = move[2]
  end

  def display(game_state)
    display_row([1, 2, 3], 0)
    game_state.each_with_index do |row, i|
      14.times { print "-" }
      puts "-"
      display_row(row, i + 1)
    end
    14.times { print "-" }
    puts "-"
  end

  def display_row(row, row_num)
    print "#{row_num} "
    row.each do |char|
      print "| "
      if char.nil?
        print "  "
      else
        print "#{char} "
      end
    end
    puts "|"
  end
end
