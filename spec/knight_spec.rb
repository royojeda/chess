require './lib/Pieces/knight'

describe Knight do
  describe '#moves' do
    subject(:move_knight) { described_class.new(color: 'white') }

    it 'returns an array of all proper knight moves' do
      expected = [[[1, 2]], [[2, 1]], [[2, -1]], [[1, -2]], [[-1, -2]], [[-2, -1]], [[-2, 1]], [[-1, 2]]].sort
      expect(move_knight.moves.sort).to eq(expected)
    end
  end
end
