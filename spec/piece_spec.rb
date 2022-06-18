require './lib/Pieces/piece'

describe Piece do
  describe '#moved' do
    subject(:moved_piece) { described_class.new(color: 'white') }

    it 'sets @first_move to false' do
      moved_piece.moved
      expect(moved_piece.first_move).to be(false)
    end
  end
end
