require './lib/Pieces/piece'
require './lib/square'

describe Piece do
  describe '#moved' do
    subject(:moved_piece) { described_class.new(color: 'white') }

    it 'sets @first_move to false' do
      moved_piece.moved
      expect(moved_piece.first_move).to be(false)
    end
  end

  describe '#location' do
    subject(:location_piece) { described_class.new(color: 'white', square: test_square) }

    context 'when the piece is at e2' do
      let(:test_square) { instance_double(Square, file: 'e', rank: '2') }

      it "returns an array of the piece's square's file and rank" do
        expected = %w[e 2]
        expect(location_piece.location).to eq(expected)
      end
    end

    context 'when the piece is at b7' do
      let(:test_square) { instance_double(Square, file: 'b', rank: '7') }

      it "returns an array of the piece's square's file and rank" do
        expected = %w[b 7]
        expect(location_piece.location).to eq(expected)
      end
    end
  end
end
