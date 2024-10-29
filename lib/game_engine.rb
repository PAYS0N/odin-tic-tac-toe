# frozen_string_literal: true

require_relative("gameover_checker")

# Game class stores and updates the state of a tic-tac-toe game
class GameEngine
  def initialize(player1, player2)
    @game_state = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @player1 = player1
    @player2 = player2
    @player_to_move = @player1
    @gameover_checker = GameoverChecker.new
  end

  def play_game
    explain_game
    rounds = 1
    game_over = play_round
    until game_over || rounds == 9
      game_over = play_round
      rounds += 1
    end
    end_game
  end

  private

  def explain_game
    puts "On your turn, enter the row and column you want to select. For example, if\n"
    puts "you want to select the example cell below, you would enter 3 and then 2."
    display([[nil, nil, nil], [nil, nil, nil], [nil, "X", nil]])
  end

  def play_round
    player_move = nil
    loop do
      player_move = @player_to_move.ask_move
      break if @game_state[player_move[0] - 1][player_move[1] - 1].nil?

      puts "Invalid move."
    end
    update_game(player_move)
    @player_to_move = @player_to_move == @player1 ? @player2 : @player1
    display(@game_state)
    @gameover_checker.game_over?(player_move, @game_state)
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

  def end_game
    puts "Game Over"
  end
end
