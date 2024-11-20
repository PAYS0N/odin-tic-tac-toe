# frozen_string_literal: true

require_relative("../lib/gameover_checker")

describe GameoverChecker do
  subject(:gameover) { described_class.new }

  context "#game_over?" do
    context "when game is not over" do
      before do
        allow(gameover).to receive(:check_row)
        allow(gameover).to receive(:check_col)
        allow(gameover).to receive(:check_diagonals)
      end

      it "sends 3 calls" do
        expect(gameover).to receive(:check_row)
        expect(gameover).to receive(:check_col)
        expect(gameover).to receive(:check_diagonals)
        gameover.game_over?([1, 3, "@"], [[nil, nil, "@"], [nil, nil, nil], [nil, nil, nil]])
      end
    end

    context "when diagonal is filled" do
      before do
        allow(gameover).to receive(:check_row)
        allow(gameover).to receive(:check_col)
        allow(gameover).to receive(:check_diagonals).and_return(true)
      end

      it "sends 3 calls" do
        expect(gameover).to receive(:check_row)
        expect(gameover).to receive(:check_col)
        expect(gameover).to receive(:check_diagonals)
        gameover.game_over?([1, 3, "@"], [])
      end
    end

    context "when column is filled" do
      before do
        allow(gameover).to receive(:check_row)
        allow(gameover).to receive(:check_col).and_return(true)
      end

      it "sends 2 calls" do
        expect(gameover).to receive(:check_row)
        expect(gameover).to receive(:check_col)
        expect(gameover).to_not receive(:check_diagonals)
        gameover.game_over?([1, 3, "@"], [])
      end
    end

    context "when row is filled" do
      before do
        allow(gameover).to receive(:check_row).and_return(true)
      end

      it "sends only 1 call" do
        expect(gameover).to receive(:check_row)
        expect(gameover).to_not receive(:check_col)
        expect(gameover).to_not receive(:check_diagonals)
        gameover.game_over?([1, 3, "@"], [])
      end
    end
  end
end
