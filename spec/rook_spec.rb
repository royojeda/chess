require "./lib/Pieces/rook"

describe Rook do
  describe "#moves" do
    subject(:move_rook) { described_class.new(color: "white") }

    let(:upward_moves) { [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]] }
    let(:downward_moves) { [[0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]] }
    let(:leftward_moves) { [[-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]] }
    let(:rightward_moves) { [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]] }

    it "returns an array of all proper rook moves" do
      expected = [upward_moves, downward_moves, leftward_moves, rightward_moves].sort
      expect(move_rook.moves.sort).to eq(expected)
    end
  end
end
