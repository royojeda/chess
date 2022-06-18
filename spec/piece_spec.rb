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

  describe '#previous_is_two_forward?' do
    subject(:previous_piece) { described_class.new(color: 'white', square: test_square, previous: test_previous) }

    context "when the piece's square's rank is two greater than its previous square's rank" do
      let(:test_square) { instance_double(Square, file: 'd', rank: '5') }
      let(:test_previous) { instance_double(Square, file: 'd', rank: '3') }

      it 'returns true' do
        expect(previous_piece.previous_is_two_forward?).to be(true)
      end
    end

    context "when the piece's square's rank is two less than its previous square's rank" do
      let(:test_square) { instance_double(Square, file: 'd', rank: '1') }
      let(:test_previous) { instance_double(Square, file: 'd', rank: '3') }

      it 'returns true' do
        expect(previous_piece.previous_is_two_forward?).to be(true)
      end
    end

    context "when the piece's square's rank is neither two less than nor two greater than its previous square's rank" do
      let(:test_square) { instance_double(Square, file: 'd', rank: '7') }
      let(:test_previous) { instance_double(Square, file: 'd', rank: '3') }

      it 'returns false' do
        expect(previous_piece.previous_is_two_forward?).to be(false)
      end
    end
  end
end
