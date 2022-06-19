require './lib/square'
require './lib/Pieces/pawn'
require './lib/Pieces/rook'

describe Square do
  describe '#place' do
    subject(:place_square) { described_class.new(file: 'a', rank: '1') }

    let(:test_piece) { instance_double(Pawn) }

    it 'sets @occupant to the given piece' do
      place_square.place(test_piece)
      expect(place_square.occupant).to eq(test_piece)
    end
  end

  describe '#remove_occupant' do
    subject(:remove_square) { described_class.new(file: 'a', rank: '1') }

    it "sets @occupant to ' '(single space string)" do
      remove_square.remove_occupant
      expected = ' '
      expect(remove_square.occupant).to eq(expected)
    end
  end

  describe '#update_occupant' do
    subject(:update_square) { described_class.new(file: 'a', rank: '1') }

    let(:test_piece) { instance_double(Pawn) }
    let(:test_source) { described_class.new(file: 'b', rank: '3') }

    before do
      allow(test_piece).to receive(:square=)
      allow(test_piece).to receive(:moved)
      allow(test_source).to receive(:occupant).and_return(test_piece)
    end

    it "sets @occupant to the source's @occupant" do
      update_square.update_occupant(test_source)
      expected = test_piece
      expect(update_square.occupant).to eq(expected)
    end
  end

  describe '#can_castle?' do
    subject(:castle_square) { described_class.new(file: 'a', rank: '1') }

    context "when @occupant is a rook of the same color(as the argument) that hasn't moved yet" do
      let(:test_rook) { instance_double(Rook, color: 'white', first_move: true) }

      before do
        allow(castle_square).to receive(:occupant).and_return(test_rook)
        allow(test_rook).to receive(:is_a?).with(Rook).and_return(true)
      end

      it 'returns true' do
        expect(castle_square.can_castle?('white')).to be(true)
      end
    end

    context 'when @occupant is a rook of the same color(as the argument) that has already moved' do
      let(:test_rook) { instance_double(Rook, color: 'white', first_move: false) }

      before do
        allow(castle_square).to receive(:occupant).and_return(test_rook)
        allow(test_rook).to receive(:is_a?).with(Rook).and_return(true)
      end

      it 'returns false' do
        expect(castle_square.can_castle?('white')).to be(false)
      end
    end

    context 'when @occupant is not a rook of the same color(as the argument)' do
      let(:test_occupant) { instance_double(Pawn, color: 'white', first_move: true) }

      before do
        allow(castle_square).to receive(:occupant).and_return(test_occupant)
        allow(test_occupant).to receive(:is_a?).with(Rook).and_return(false)
      end

      it 'returns false' do
        expect(castle_square.can_castle?('white')).to be(false)
      end
    end
  end
end
