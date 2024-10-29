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
    game_over = play_round until game_over
    end_game
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
    game_over?(player_move)
  end

  def game_over?(move)
    row = move[0] - 1
    col = move[1] - 1
    sym = move[2]
    check_row(row, sym) || check_col(col, sym) || check_diagonals([row, col], sym)
  end

  def check_row(row, player_char)
    game_over = true
    @game_state[row].each do |char|
      game_over = false unless char == player_char
    end
    game_over
  end

  def check_col(col, player_char)
    game_over = true
    @game_state.map { |arr| arr[col] }.each do |char|
      game_over = false unless char == player_char
    end
    game_over
  end

  def check_diagonals(move, sym)
    if move == [1, 1] && check_both_diags(sym)
      true
    else
      (move[0] == move[1] && check_left_diag(sym)) || ([[0, 2], [2, 0]].include?(move) && check_right_diag(sym))
    end
  end

  def check_both_diags(char)
    return true if check_left_diag(char)

    check_right_diag(char)
  end

  def check_left_diag(char)
    game_over = true
    (0..2).each do |i|
      game_over = false unless @game_state[i][i] == char
    end
    game_over
  end

  def check_right_diag(char)
    game_over = true
    (0..2).each do |i|
      game_over = false unless @game_state[i][2 - i] == char
    end
    game_over
  end

  # check if move is legal
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
