require './lib/square'
require './lib/Pieces/pawn'

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
end
