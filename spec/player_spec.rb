# frozen_string_literal: true

require_relative("../lib/player")

describe Player do
  context "on player startup" do
    subject(:new_player) { described_class.new }

    before do
      allow(new_player).to receive(:grab_name)
      allow(new_player).to receive(:grab_player_character)
    end

    it "sends call to get name" do
      expect(new_player).to receive(:grab_name)
      new_player.startup
    end

    it "sends call to get character" do
      expect(new_player).to receive(:grab_player_character)
      new_player.startup
    end
  end

  context "when asking for a move" do
    subject(:player_moving) { described_class.new }

    before do
      allow(player_moving).to receive(:ask_row)
      allow(player_moving).to receive(:ask_column)
    end

    it "sends call to get row" do
      expect(player_moving).to receive(:ask_row)
      player_moving.ask_move
    end

    it "sends call to get column" do
      expect(player_moving).to receive(:ask_column)
      player_moving.ask_move
    end
  end

  context "when asking for player character" do
    subject(:player_char) { described_class.new }

    before do
      allow(player_char).to receive(:verify_input).and_return("A")
    end

    it "sends call to get verified input" do
      expect(player_char).to receive(:verify_input)
      player_char.grab_player_character
    end
  end

  context "when asking for player name" do
    subject(:player_name) { described_class.new }

    before do
      allow(player_name).to receive(:verify_input).and_return("valid string")
    end

    it "sends call to get verified input" do
      expect(player_name).to receive(:verify_input)
      player_name.grab_name
    end
  end

  context "when validating input" do
    subject(:player_validation) { described_class.new }

    context "when no block is given" do
      context "when input is non-empty" do
        before do
          allow(player_validation).to receive(:puts)
          allow(player_validation).to receive(:gets).and_return("string\n")
        end

        it "asks for input" do
          expect(player_validation).to receive(:puts)
          player_validation.verify_input("get input")
        end

        it "returns the input" do
          result = player_validation.verify_input("get input")
          expect(result).to eq("string")
        end
      end

      context "when empty once, and then valid" do
        before do
          allow(player_validation).to receive(:puts)
          allow(player_validation).to receive(:gets).and_return("", "string")
        end

        it "prints twice" do
          expect(player_validation).to receive(:puts).with("get input")
          expect(player_validation).to receive(:puts).with("Invalid, try again.")
          player_validation.verify_input("get input")
        end

        it "returns the input" do
          result = player_validation.verify_input("get input")
          expect(result).to eq("string")
        end
      end

      context "when input is invalid n times, then valid" do
        before do
          allow(player_validation).to receive(:puts)
          allow(player_validation).to receive(:gets).and_return("\n", "", "", "", "", "string\n")
        end

        it "prints n+1 times" do
          expect(player_validation).to receive(:puts).with("get input")
          expect(player_validation).to receive(:puts).with("Invalid, try again.").exactly(5).times
          player_validation.verify_input("get input")
        end

        it "returns the input" do
          result = player_validation.verify_input("get input")
          expect(result).to eq("string")
        end
      end
    end
    context "when block is not empty" do
      let(:preprocess) { ->(str) { str.chomp.to_i } }
      let(:test) { ->(num) { (1..3).include?(num) } }
      context "when input passes block" do
        before do
          allow(player_validation).to receive(:puts)
          allow(player_validation).to receive(:gets).and_return("2\n")
        end

        it "asks for input" do
          expect(player_validation).to receive(:puts)
          player_validation.verify_input("get input message", "error message", preprocess, test)
        end

        it "returns the input" do
          result = player_validation.verify_input("get input message", "error message", preprocess, test)
          expect(result).to eq(2)
        end
      end

      context "when input fails once, then is valid" do
        before do
          allow(player_validation).to receive(:puts)
          allow(player_validation).to receive(:gets).and_return("abc", "3")
        end

        it "prints twice" do
          expect(player_validation).to receive(:puts).twice
          player_validation.verify_input("get input message", "error message", preprocess, test)
        end

        it "returns the input" do
          result = player_validation.verify_input("get input message", "error message", preprocess, test)
          expect(result).to eq(3)
        end
      end

      context "when input is invalid n times, then valid" do
        before do
          allow(player_validation).to receive(:puts)
          allow(player_validation).to receive(:gets).and_return("123", "abc", "\n", "  ", "-1", "1")
        end

        it "prints n+1 times" do
          expect(player_validation).to receive(:puts).exactly(6).times
          player_validation.verify_input("get input message", "error message", preprocess, test)
        end

        it "returns the input" do
          result = player_validation.verify_input("get input message", "error message", preprocess, test)
          expect(result).to eq(1)
        end
      end
    end
  end
end
