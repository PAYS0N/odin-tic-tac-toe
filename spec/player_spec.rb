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

  context "when asking for row number" do
    subject(:player_row) { described_class.new }

    context "when number is equal to 1 or 3" do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return("3")
      end

      it "asks once and returns the same number" do
        expect(subject).to receive(:puts)
        result = player_row.ask_row
        expect(result).to eq(3)
      end
    end

    context "when number is between 1 and 3" do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return("2")
      end

      it "asks once and returns the same number" do
        expect(subject).to receive(:puts)
        result = player_row.ask_row
        expect(result).to eq(2)
      end
    end

    context "when number is not between 1 or 3, and then is" do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return("4", "3")
      end

      it "asks twice and returns the same number" do
        expect(subject).to receive(:puts).twice
        result = player_row.ask_row
        expect(result).to eq(3)
      end
    end

    context "when number is incorrect n times, and then is correct" do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return("4", "43", "efv", "a", "cerlijib", "\n", "", "1")
      end

      it "asks n+1 times and returns the final number" do
        expect(subject).to receive(:puts).exactly(8).times
        result = player_row.ask_row
        expect(result).to eq(1)
      end
    end
  end

  context "when asking for column number" do
    subject(:player_column) { described_class.new }

    context "when number is equal to 1 or 3" do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return("3")
      end

      it "asks once and returns the same number" do
        expect(subject).to receive(:puts)
        result = player_column.ask_column
        expect(result).to eq(3)
      end
    end

    context "when number is between 1 and 3" do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return("2")
      end

      it "asks once and returns the same number" do
        expect(subject).to receive(:puts)
        result = player_column.ask_column
        expect(result).to eq(2)
      end
    end

    context "when number is not between 1 or 3, and then is" do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return("4", "3")
      end

      it "asks twice and returns the same number" do
        expect(subject).to receive(:puts).twice
        result = player_column.ask_column
        expect(result).to eq(3)
      end
    end

    context "when number is incorrect n times, and then is correct" do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return("4", "43", "efv", "a", "cerlijib", "\n", "", "1")
      end

      it "asks n+1 times and returns the final number" do
        expect(subject).to receive(:puts).exactly(8).times
        result = player_column.ask_column
        expect(result).to eq(1)
      end
    end
  end

  context "when asking for player character" do
    subject(:player_char) { described_class.new }

    context "when character is valid" do
      before do
        allow(player_char).to receive(:puts)
      end

      it "returns the character" do
        allow(player_char).to receive(:gets).and_return("@")
        expect(player_char).to receive(:puts)
        result = player_char.grab_player_character
        expect(result).to eq("@")
      end

      it "returns the character" do
        allow(player_char).to receive(:gets).and_return("X")
        expect(player_char).to receive(:puts)
        result = player_char.grab_player_character
        expect(result).to eq("X")
      end
    end

    context "when character is invalid once, then valid" do
      before do
        allow(player_char).to receive(:puts)
        allow(player_char).to receive(:gets).and_return("ergtgetr", "@")
      end

      it "prints twice, then returns the character" do
        expect(player_char).to receive(:puts).twice
        result = player_char.grab_player_character
        expect(result).to eq("@")
      end
    end

    context "when character is invalid n times, then valid" do
      before do
        allow(player_char).to receive(:puts)
        allow(player_char).to receive(:gets).and_return("", "\n", "123", "fvt", "☺☻", "-♠┘♀", "`l", "\\\\", "./", "@")
      end

      it "prints n+1 times, then returns the character" do
        expect(player_char).to receive(:puts).exactly(10).times
        result = player_char.grab_player_character
        expect(result).to eq("@")
      end
    end
  end

  context "when asking for player name" do
    subject(:player_name) { described_class.new }

    context "when name is non-empty" do
      before do
        allow(player_name).to receive(:puts)
      end

      it "prints query and returns name" do
        allow(player_name).to receive(:gets).and_return("kuerb")
        expect(player_name).to receive(:puts)
        result = player_name.grab_name
        expect(result).to eq("kuerb")
      end

      it "returns the name" do
        allow(player_name).to receive(:gets).and_return("-12")
        expect(player_name).to receive(:puts)
        result = player_name.grab_name
        expect(result).to eq("-12")
      end
    end

    context "when name is empty once, then valid" do
      before do
        allow(player_name).to receive(:puts)
        allow(player_name).to receive(:gets).and_return("", "@")
      end

      it "prints twice, then returns the name" do
        expect(player_name).to receive(:puts).twice
        result = player_name.grab_name
        expect(result).to eq("@")
      end
    end

    context "when name is invalid n times, then valid" do
      before do
        allow(player_name).to receive(:puts)
        allow(player_name).to receive(:gets).and_return("", "\n", " ", "\t", "Payson")
      end

      it "prints n+1 times, then returns the name" do
        expect(player_name).to receive(:puts).exactly(5).times
        result = player_name.grab_name
        expect(result).to eq("Payson")
      end
    end
  end
end
