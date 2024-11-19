# frozen_string_literal: true

require_relative("../lib/player")

describe Player do
  # no idea how to test this well, did a lot of research and conclusion is don't do this but nothing else works
  context "when a player is created" do
    before do
      allow_any_instance_of(described_class).to receive(:grab_name)
      allow_any_instance_of(described_class).to receive(:grab_player_character)
    end

    it "calls function to get name" do
      expect_any_instance_of(described_class).to receive(:grab_name)
      player = described_class.new
    end

    it "calls function to get character" do
      expect_any_instance_of(described_class).to receive(:grab_player_character)
      player = described_class.new
    end

    it "increments total number of players" do
      expect
    end
  end
end
