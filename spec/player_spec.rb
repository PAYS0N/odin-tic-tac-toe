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

    it "sends call to get name" do
      expect(player_moving).to receive(:ask_row)
      player_moving.ask_move
    end

    it "sends call to get character" do
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
end
