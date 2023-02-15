require "./lib/Pieces/queen"

describe Queen do
  # rubocop:disable RSpec/MultipleMemoizedHelpers
  describe "#moves" do
    subject(:move_queen) { described_class.new(color: "white") }

    let(:upward_moves) { [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]] }
    let(:downward_moves) { [[0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]] }
    let(:leftward_moves) { [[-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]] }
    let(:rightward_moves) { [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]] }
    let(:up_right_moves) { [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]] }
    let(:up_left_moves) { [[-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]] }
    let(:down_right_moves) { [[1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7]] }
    let(:down_left_moves) { [[-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]] }

    it "returns an array of all proper queen moves" do
      expected = [upward_moves, downward_moves, leftward_moves, rightward_moves, up_right_moves, up_left_moves,
        down_right_moves, down_left_moves].sort
      expect(move_queen.moves.sort).to eq(expected)
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers
end
