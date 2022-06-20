require './lib/Pieces/bishop'

describe Bishop do
  describe '#moves' do
    subject(:move_bishop) { described_class.new(color: 'white') }

    let(:up_right_moves) { [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]] }
    let(:up_left_moves) { [[-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]] }
    let(:down_right_moves) { [[1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7]] }
    let(:down_left_moves) { [[-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]] }

    it 'returns an array of all proper bishop moves' do
      expected = [up_right_moves, up_left_moves, down_right_moves, down_left_moves].sort
      expect(move_bishop.moves.sort).to eq(expected)
    end
  end
end
