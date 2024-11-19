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
end
