# frozen_string_literal: true

# Checks if the game is over
class GameoverChecker
  def game_over?(move, game)
    @game_state = game
    row = move[0] - 1
    col = move[1] - 1
    sym = move[2]
    check_row(row, sym) || check_col(col, sym) || check_diagonals([row, col], sym)
  end

  def check_row(row, player_char)
    @game_state[row].each do |char|
      return false unless char == player_char
    end
    true
  end

  def check_col(col, player_char)
    @game_state.map { |arr| arr[col] }.each do |char|
      return false unless char == player_char
    end
    true
  end

  def check_diagonals(move, sym)
    if move == [1, 1]
      check_both_diags(sym)
    else
      (move[0] == move[1] && check_left_diag(sym)) || ([[0, 2], [2, 0]].include?(move) && check_right_diag(sym))
    end
  end

  def check_both_diags(char)
    return true if check_left_diag(char)

    check_right_diag(char)
  end

  def check_left_diag(char)
    (0..2).each do |i|
      return false unless @game_state[i][i] == char
    end
    true
  end

  def check_right_diag(char)
    (0..2).each do |i|
      return false unless @game_state[i][2 - i] == char
    end
    true
  end
end
