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

  context "#check_row" do
    context "when row is all the passed char" do
      before do
        gameover.instance_variable_set(:@game_state, [[], [], ["@", "@", "@"]])
      end

      it "return true" do
        result = gameover.check_row(2, "@")
        expect(result).to be_truthy
      end
    end

    context "when row has a different char" do
      before do
        gameover.instance_variable_set(:@game_state, [[], [], ["@", "@", "!"]])
      end

      it "return false" do
        result = gameover.check_row(2, "@")
        expect(result).to be_falsy
      end
    end
  end

  context "#check_col" do
    context "when col is all the passed char" do
      before do
        gameover.instance_variable_set(:@game_state, [["@"], ["@"], ["@"]])
      end

      it "return true" do
        result = gameover.check_col(0, "@")
        expect(result).to be_truthy
      end
    end

    context "when col has a different char" do
      before do
        gameover.instance_variable_set(:@game_state, [["@"], ["@"], ["!"]])
      end

      it "return false" do
        result = gameover.check_col(0, "@")
        expect(result).to be_falsy
      end
    end
  end

  context "#check_diagonals" do
    context "when move is center square" do
      before do
        allow(gameover).to receive(:check_both_diags)
        allow(gameover).to receive(:check_left_diag)
        allow(gameover).to receive(:check_right_diag)
      end

      it "sends call to check both diagonals" do
        expect(gameover).to receive(:check_both_diags)
        expect(gameover).to_not receive(:check_left_diag)
        expect(gameover).to_not receive(:check_right_diag)
        gameover.check_diagonals([1, 1], "@")
      end

      context "when check passes" do
        before do
          allow(gameover).to receive(:check_both_diags).and_return(true)
        end

        it "returns true" do
          result = gameover.check_diagonals([1, 1], "@")
          expect(result).to be_truthy
        end
      end

      context "when check fails" do
        before do
          allow(gameover).to receive(:check_both_diags).and_return(false)
        end

        it "returns false" do
          result = gameover.check_diagonals([1, 1], "@")
          expect(result).to be_falsy
        end
      end
    end

    context "when move is not center square" do
      context "when move is on left diagonal" do
        before do
          allow(gameover).to receive(:check_both_diags)
          allow(gameover).to receive(:check_left_diag)
          allow(gameover).to receive(:check_right_diag)
        end

        it "sends call to check only left diagonal" do
          expect(gameover).to_not receive(:check_both_diags)
          expect(gameover).to receive(:check_left_diag)
          expect(gameover).to_not receive(:check_right_diag)
          gameover.check_diagonals([2, 2], "@")
        end

        context "when check passes" do
          before do
            allow(gameover).to receive(:check_left_diag).and_return(true)
          end

          it "returns true" do
            result = gameover.check_diagonals([2, 2], "@")
            expect(result).to be_truthy
          end
        end

        context "when check fails" do
          before do
            allow(gameover).to receive(:check_left_diag).and_return(false)
          end

          it "returns false" do
            result = gameover.check_diagonals([2, 2], "@")
            expect(result).to be_falsy
          end
        end
      end

      context "when move is on right diagonal" do
        before do
          allow(gameover).to receive(:check_both_diags)
          allow(gameover).to receive(:check_left_diag)
          allow(gameover).to receive(:check_right_diag)
        end

        it "sends call to check only right diagonal" do
          expect(gameover).to_not receive(:check_both_diags)
          expect(gameover).to_not receive(:check_left_diag)
          expect(gameover).to receive(:check_right_diag)
          gameover.check_diagonals([0, 2], "@")
        end

        context "when check passes" do
          before do
            allow(gameover).to receive(:check_right_diag).and_return(true)
          end

          it "returns true" do
            result = gameover.check_diagonals([0, 2], "@")
            expect(result).to be_truthy
          end
        end

        context "when check fails" do
          before do
            allow(gameover).to receive(:check_right_diag).and_return(false)
          end

          it "returns false" do
            result = gameover.check_diagonals([0, 2], "@")
            expect(result).to be_falsy
          end
        end
      end
    end
  end

  context "#check_both_diags" do
    context "when left diagonal passes" do
      before do
        allow(gameover).to receive(:check_left_diag).and_return(true)
        allow(gameover).to receive(:check_right_diag)
      end

      it "calls check_left" do
        expect(gameover).to receive(:check_left_diag)
        gameover.check_both_diags("@")
      end

      it "doesn't call check_right" do
        expect(gameover).to_not receive(:check_right_diag)
        gameover.check_both_diags("@")
      end

      it "returns true" do
        result = gameover.check_both_diags("@")
        expect(result).to be_truthy
      end
    end

    context "when left diagonal fails and right passes" do
      before do
        allow(gameover).to receive(:check_left_diag).and_return(false)
        allow(gameover).to receive(:check_right_diag).and_return(true)
      end

      it "calls check_left" do
        expect(gameover).to receive(:check_left_diag)
        gameover.check_both_diags("@")
      end

      it "calls check_right" do
        expect(gameover).to receive(:check_right_diag)
        gameover.check_both_diags("@")
      end

      it "returns true" do
        result = gameover.check_both_diags("@")
        expect(result).to be_truthy
      end
    end

    context "when left diagonal fails and right fails" do
      before do
        allow(gameover).to receive(:check_left_diag).and_return(false)
        allow(gameover).to receive(:check_right_diag).and_return(false)
      end

      it "calls check_left" do
        expect(gameover).to receive(:check_left_diag)
        gameover.check_both_diags("@")
      end

      it "calls check_right" do
        expect(gameover).to receive(:check_right_diag)
        gameover.check_both_diags("@")
      end

      it "returns false" do
        result = gameover.check_both_diags("@")
        expect(result).to be_falsy
      end
    end
  end
end
