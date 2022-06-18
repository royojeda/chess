require './lib/Pieces/pawn'

describe Pawn do
  describe '#moves' do
    subject(:move_pawn) { described_class.new(color: 'white') }

    it 'returns an array of all proper pawn moves' do
      expected = [[[0, 1], [0, 2]]].sort
      expect(move_pawn.moves.sort).to eq(expected)
    end
  end

  describe '#specials' do
    context 'when the pawn is white' do
      subject(:special_white_pawn) { described_class.new(color: 'white') }

      it "returns the white pawn's capture moves" do
        expected = [[-1, 1], [1, 1]].sort
        expect(special_white_pawn.specials.sort).to eq(expected)
      end
    end

    context 'when the pawn is black' do
      subject(:special_black_pawn) { described_class.new(color: 'black') }

      it "returns the black pawn's capture moves" do
        expected = [[1, -1], [-1, -1]].sort
        expect(special_black_pawn.specials.sort).to eq(expected)
      end
    end
  end
end
