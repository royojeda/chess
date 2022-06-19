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

  describe '#contains_own_king?' do
    subject(:king_square) { described_class.new(file: 'a', rank: '1') }

    context 'when @occupant is a king of the same color(as the argument)' do
      let(:test_occupant) { instance_double(King, color: 'white', first_move: true) }

      before do
        allow(king_square).to receive(:occupant).and_return(test_occupant)
        allow(test_occupant).to receive(:is_a?).with(King).and_return(true)
      end

      it 'returns true' do
        expect(king_square.contains_own_king?('white')).to be(true)
      end
    end

    context 'when @occupant is a king not of the same color(as the argument)' do
      let(:test_occupant) { instance_double(King, color: 'black', first_move: true) }

      before do
        allow(king_square).to receive(:occupant).and_return(test_occupant)
        allow(test_occupant).to receive(:is_a?).with(King).and_return(true)
      end

      it 'returns false' do
        expect(king_square.contains_own_king?('white')).to be(false)
      end
    end

    context 'when @occupant is not a king' do
      let(:test_occupant) { instance_double(Pawn, color: 'white', first_move: true) }

      before do
        allow(king_square).to receive(:occupant).and_return(test_occupant)
        allow(test_occupant).to receive(:is_a?).with(King).and_return(false)
      end

      it 'returns false' do
        expect(king_square.contains_own_king?('white')).to be(false)
      end
    end
  end

  describe '#contains_enemy_pawn' do
    subject(:pawn_square) { described_class.new(file: 'a', rank: '1') }

    context 'when @occupant is a pawn not of the same color(as the argument)' do
      let(:test_occupant) { instance_double(Pawn, color: 'black', first_move: true) }

      before do
        allow(pawn_square).to receive(:occupant).and_return(test_occupant)
        allow(test_occupant).to receive(:is_a?).with(Pawn).and_return(true)
      end

      it 'returns true' do
        expect(pawn_square.contains_enemy_pawn?('white')).to be(true)
      end
    end

    context 'when @occupant is a pawn of the same color(as the argument)' do
      let(:test_occupant) { instance_double(Pawn, color: 'white', first_move: true) }

      before do
        allow(pawn_square).to receive(:occupant).and_return(test_occupant)
        allow(test_occupant).to receive(:is_a?).with(Pawn).and_return(true)
      end

      it 'returns false' do
        expect(pawn_square.contains_enemy_pawn?('white')).to be(false)
      end
    end

    context 'when @occupant is not a pawn' do
      let(:test_occupant) { instance_double(King, color: 'white', first_move: true) }

      before do
        allow(pawn_square).to receive(:occupant).and_return(test_occupant)
        allow(test_occupant).to receive(:is_a?).with(Pawn).and_return(false)
      end

      it 'returns false' do
        expect(pawn_square.contains_enemy_pawn?('white')).to be(false)
      end
    end
  end

  describe '#promotable?' do
    context 'when @occupant is a white pawn on the 8th rank' do
      subject(:promotable_square) { described_class.new(file: 'c', rank: '8') }

      let(:test_occupant) { instance_double(Pawn, color: 'white') }

      before do
        allow(promotable_square).to receive(:occupant).and_return(test_occupant)
        allow(test_occupant).to receive(:is_a?).with(Pawn).and_return(true)
      end

      it 'returns true' do
        expect(promotable_square.promotable?).to be(true)
      end
    end

    context 'when @occupant is a black pawn on the 1st rank' do
      subject(:promotable_square) { described_class.new(file: 'c', rank: '1') }

      let(:test_occupant) { instance_double(Pawn, color: 'black') }

      before do
        allow(promotable_square).to receive(:occupant).and_return(test_occupant)
        allow(test_occupant).to receive(:is_a?).with(Pawn).and_return(true)
      end

      it 'returns true' do
        expect(promotable_square.promotable?).to be(true)
      end
    end

    context 'when @occupant is a pawn not on the 1st or 8th rank' do
      subject(:promotable_square) { described_class.new(file: 'c', rank: '5') }

      let(:test_occupant) { instance_double(Pawn, color: 'white') }

      before do
        allow(promotable_square).to receive(:occupant).and_return(test_occupant)
        allow(test_occupant).to receive(:is_a?).with(Pawn).and_return(true)
      end

      it 'returns false' do
        expect(promotable_square.promotable?).to be(false)
      end
    end
  end
end
