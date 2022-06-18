require './lib/Pieces/king'

describe King do
  describe '#moves' do
    subject(:move_king) { described_class.new(color: 'white') }

    it 'returns an array of all proper king moves' do
      expected = [[[0, 1]], [[1, 1]], [[1, 0]], [[1, -1]], [[0, -1]], [[-1, -1]], [[-1, 0]], [[-1, 1]]].sort
      expect(move_king.moves.sort).to eq(expected)
    end
  end
end
