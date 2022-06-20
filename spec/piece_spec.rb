require './lib/Pieces/piece'
require './lib/square'
require './lib/board'

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

  describe '#all_destinations' do
    subject(:destination_piece) { described_class.new(color: 'white', square: test_square) }

    let(:test_board) { instance_double(Board) }
    let(:test_square) { instance_double(Square, file: 'c', rank: '3') }
    let(:test_destination_one) { instance_double(Square, file: 'd', rank: '3') }
    let(:test_destination_two) { instance_double(Square, file: 'e', rank: '3') }
    let(:test_destination_three) { instance_double(Square, file: 'f', rank: '3') }

    before do
      move_one = [0, 1]
      move_two = [0, 2]
      move_three = [0, 3]
      moves = [[move_one, move_two, move_three]]
      allow(destination_piece).to receive(:moves).and_return(moves)
      allow(destination_piece).to receive(:destination_from).with(move_one).and_return(test_destination_one)
      allow(destination_piece).to receive(:destination_from).with(move_two).and_return(test_destination_two)
      allow(destination_piece).to receive(:destination_from).with(move_three).and_return(test_destination_three)
    end

    context "when the piece's moves are not blocked by any other piece" do
      before do
        allow(destination_piece).to receive(:stop_before?).and_return(false, false, false)
        allow(destination_piece).to receive(:stop_after?).and_return(false, false, false)
      end

      it 'returns an array with all destinations' do
        expected = [test_destination_one, test_destination_two, test_destination_three]
        expect(destination_piece.all_destinations(test_board)).to eq(expected)
      end
    end

    context "when the piece's second move is blocked by an allied piece" do
      before do
        allow(destination_piece).to receive(:stop_before?).and_return(false, true, false)
        allow(destination_piece).to receive(:stop_after?).and_return(false, false, false)
      end

      it 'returns an array with the first destination' do
        expected = [test_destination_one]
        expect(destination_piece.all_destinations(test_board)).to eq(expected)
      end
    end

    context "when the piece's second move is blocked by an enemy piece" do
      before do
        allow(destination_piece).to receive(:stop_before?).and_return(false, false, false)
        allow(destination_piece).to receive(:stop_after?).and_return(false, true, false)
      end

      it 'returns an array with the first and second destinations' do
        expected = [test_destination_one, test_destination_two]
        expect(destination_piece.all_destinations(test_board)).to eq(expected)
      end
    end

    context "when the piece's first move is blocked by an allied piece" do
      before do
        allow(destination_piece).to receive(:stop_before?).and_return(true, false, false)
        allow(destination_piece).to receive(:stop_after?).and_return(false, false, false)
      end

      it 'returns an empty array' do
        expected = []
        expect(destination_piece.all_destinations(test_board)).to eq(expected)
      end
    end
  end
end
