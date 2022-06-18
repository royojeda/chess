require './lib/Pieces/pawn'

describe Pawn do
  describe '#moves' do
    subject(:move_pawn) { described_class.new(color: 'white') }

    it 'returns an array of all proper pawn moves' do
      expected = [[[0, 1], [0, 2]]].sort
      expect(move_pawn.moves.sort).to eq(expected)
    end
  end
end
