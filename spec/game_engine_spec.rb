# frozen_string_literal: true

require_relative("../lib/game_engine")

describe GameEngine do
  let(:player1) { instance_double("player") }
  let(:player2) { instance_double("player") }
  subject(:game) { described_class.new(player1, player2) }

  context "#play_game" do
    context "on call" do
      before do
        allow(game).to receive(:explain_game)
        allow(game).to receive(:play_round).and_return(true)
        allow(game).to receive(:end_game)
      end

      it "sends call to explain game" do
        expect(game).to receive(:explain_game)
        game.play_game
      end

      it "sends call to end game" do
        expect(game).to receive(:end_game)
        game.play_game
      end
    end
    context "when first round ends game" do
      before do
        allow(game).to receive(:explain_game)
        allow(game).to receive(:play_round).and_return(true)
        allow(game).to receive(:end_game)
      end

      it "calls play_round once" do
        expect(game).to receive(:play_round).once
        game.play_game
      end
    end

    context "when second round ends game" do
      before do
        allow(game).to receive(:explain_game)
        allow(game).to receive(:play_round).and_return(false, true)
        allow(game).to receive(:end_game)
      end

      it "calls play_round twice" do
        expect(game).to receive(:play_round).twice
        game.play_game
      end
    end

    context "when nth round ends game and n < 9" do
      before do
        allow(game).to receive(:explain_game)
        allow(game).to receive(:play_round).and_return(false, false, false, false, false, true)
        allow(game).to receive(:end_game)
      end

      it "calls play_round n times" do
        expect(game).to receive(:play_round).exactly(6).times
        game.play_game
      end
    end

    context "when round never ends game" do
      before do
        allow(game).to receive(:explain_game)
        allow(game).to receive(:play_round).and_return(false)
        allow(game).to receive(:end_game)
      end

      it "calls play_round 9 times" do
        expect(game).to receive(:play_round).exactly(9).times
        game.play_game
      end
    end
  end

  context "#play_round" do
    let(:checker) { instance_double("gameover_checker") }

    before do
      allow(game).to receive(:grab_move)
      allow(game).to receive(:update_game)
      allow(game).to receive(:display)
      game.instance_variable_set(:@gameover_checker, checker)
      allow(checker).to receive(:game_over?)
    end

    it "sends call to get player move" do
      expect(game).to receive(:grab_move)
      game.play_round
    end

    it "sends call to update game state" do
      expect(game).to receive(:update_game)
      game.play_round
    end

    context "when player1 went" do
      before do
        game.instance_variable_set(:@player_to_move, player1)
      end

      it "updates player to move to player 2" do
        game.play_round
        expect(game.instance_variable_get(:@player_to_move)).to eq(player2)
      end
    end

    context "when player2 went" do
      before do
        game.instance_variable_set(:@player_to_move, player2)
      end

      it "updates player to move to player 1" do
        game.play_round
        expect(game.instance_variable_get(:@player_to_move)).to eq(player1)
      end
    end

    it "sends call to display game" do
      expect(game).to receive(:display)
      game.play_round
    end

    it "sends call to check if game over" do
      expect(checker).to receive(:game_over?)
      game.play_round
    end
  end

  context "#grab_move" do
    before do
      game.instance_variable_set(:@player_to_move, player1)
    end

    context "when input is valid" do
      before do
        allow(game).to receive(:puts)
        allow(player1).to receive(:ask_move).and_return([1, 1])
        game.instance_variable_set(:@game_state, [[nil]])
      end

      it "asks for input" do
        expect(player1).to receive(:ask_move)
        game.grab_move
      end

      it "doesn't error" do
        expect(game).to_not receive(:puts)
        game.grab_move
      end

      it "returns the input" do
        result = game.grab_move
        expect(result).to eq([1, 1])
      end
    end

    context "when input is invalid, then valid" do
      before do
        allow(game).to receive(:puts)
        allow(player1).to receive(:ask_move).and_return([1, 2], [1, 1])
        game.instance_variable_set(:@game_state, [[nil, 1]])
      end

      it "asks for input twice" do
        expect(player1).to receive(:ask_move).twice
        game.grab_move
      end

      it "errors once" do
        expect(game).to receive(:puts)
        game.grab_move
      end

      it "returns the valid input" do
        result = game.grab_move
        expect(result).to eq([1, 1])
      end
    end

    context "when input is invalid n times, then valid" do
      before do
        allow(game).to receive(:puts)
        allow(player1).to receive(:ask_move).and_return([1, 2], [1, 2], [1, 2], [1, 2], [1, 1])
        game.instance_variable_set(:@game_state, [[nil, 1]])
      end

      it "asks for input n times" do
        expect(player1).to receive(:ask_move).exactly(5).times
        game.grab_move
      end

      it "errors n-1 times" do
        expect(game).to receive(:puts).exactly(4).times
        game.grab_move
      end

      it "returns the valid input" do
        result = game.grab_move
        expect(result).to eq([1, 1])
      end
    end
  end
end
