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

  describe '#special_allowed?' do
    subject(:allowed_pawn) { described_class.new(color: 'white') }

    let(:test_board) { instance_double(Board) }

    before do
      allow(allowed_pawn).to receive(:destination_from)
    end

    context 'when there is an enemy piece diagonally forward one square to the left' do
      before do
        allow(test_board).to receive(:enemy_piece_at?).and_return(true)
        allow(test_board).to receive(:allows_en_passant_by?).and_return(false)
      end

      it 'returns true for the front-left capture' do
        capture = [-1, 1]
        expect(allowed_pawn.special_allowed?(capture, test_board)).to be(true)
      end
    end

    context 'when there is an enemy piece diagonally forward one square to the right' do
      before do
        allow(test_board).to receive(:enemy_piece_at?).and_return(true)
        allow(test_board).to receive(:allows_en_passant_by?).and_return(false)
      end

      it 'returns true for the front-right capture' do
        capture = [1, 1]
        expect(allowed_pawn.special_allowed?(capture, test_board)).to be(true)
      end
    end

    context 'when the left-side en passant conditions are met' do
      before do
        allow(test_board).to receive(:enemy_piece_at?).and_return(false)
        allow(test_board).to receive(:allows_en_passant_by?).with(allowed_pawn, -1).and_return(true)
      end

      it 'returns true for the front-left capture' do
        capture = [-1, 1]
        expect(allowed_pawn.special_allowed?(capture, test_board)).to be(true)
      end
    end

    context 'when the right-side en passant conditions are met' do
      before do
        allow(test_board).to receive(:enemy_piece_at?).and_return(false)
        allow(test_board).to receive(:allows_en_passant_by?).with(allowed_pawn, 1).and_return(true)
      end

      it 'returns true for the front-right capture' do
        capture = [1, 1]
        expect(allowed_pawn.special_allowed?(capture, test_board)).to be(true)
      end
    end
  end
end
