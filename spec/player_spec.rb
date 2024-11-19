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
end
