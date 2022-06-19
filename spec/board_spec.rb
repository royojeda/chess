require './lib/board'
require './lib/square'
require './lib/Pieces/pawn'

describe Board do
  describe '#move' do
    subject(:move_board) { described_class.new }

    let(:test_source) { instance_double(Square) }
    let(:test_destination) { instance_double(Square) }

    before do
      start = %w[a 1]
      move = %w[a 4]
      allow(move_board).to receive(:square_at).with(start).and_return(test_source)
      allow(move_board).to receive(:square_at).with(move).and_return(test_destination)
      allow(move_board).to receive(:en_passant?)
      allow(test_destination).to receive(:occupant)
      allow(test_source).to receive(:highlight_blue)
      allow(test_destination).to receive(:highlight_blue)
      allow(test_source).to receive(:store_as_previous)
      allow(test_destination).to receive(:update_occupant)
      allow(test_source).to receive(:remove_occupant)
      move_board.move(start, move)
    end

    it 'sends #store_as_previous to the source square' do
      expect(test_source).to have_received(:store_as_previous)
    end

    it 'sends #update_occupant to the destination square' do
      expect(test_destination).to have_received(:update_occupant)
    end

    it 'sends #remove_occupant to the source square' do
      expect(test_source).to have_received(:remove_occupant)
    end

    it 'sends #highlight_blue to the source square' do
      expect(test_source).to have_received(:highlight_blue)
    end

    it 'sends #highlight_blue to the destination square' do
      expect(test_destination).to have_received(:highlight_blue)
    end
  end

  describe '#rook_castle_move' do
    subject(:rook_castle_board) { described_class.new }

    let(:test_source) { instance_double(Square) }
    let(:test_destination) { instance_double(Square) }

    before do
      start = %w[a 1]
      move = %w[d 1]
      allow(rook_castle_board).to receive(:square_at).with(start).and_return(test_source)
      allow(rook_castle_board).to receive(:square_at).with(move).and_return(test_destination)
      allow(test_source).to receive(:store_as_previous)
      allow(test_destination).to receive(:update_occupant)
      allow(test_source).to receive(:remove_occupant)
      rook_castle_board.rook_castle_move(move)
    end

    it 'sends #store_as_previous to the source square' do
      expect(test_source).to have_received(:store_as_previous)
    end

    it 'sends #update_occupant to the destination square' do
      expect(test_destination).to have_received(:update_occupant)
    end

    it 'sends #remove_occupant to the source square' do
      expect(test_source).to have_received(:remove_occupant)
    end
  end

  describe '#place' do
    subject(:place_board) { described_class.new }

    let(:test_piece) { instance_double(Pawn, color: 'white') }
    let(:test_square) { instance_double(Square, file: 'a', rank: '1') }

    before do
      location = %w[a 1]
      allow(place_board).to receive(:square_at).with(location).and_return(test_square)
      allow(test_square).to receive(:place)
      place_board.place(test_piece, location)
    end

    it 'sends #place with test_piece to the square at a given location' do
      expect(test_square).to have_received(:place).with(test_piece)
    end
  end

  describe '#show_moves_from' do
    subject(:show_moves_board) { described_class.new }

    let(:test_start) { instance_double(Square, file: 'e', rank: '2') }
    let(:test_destination_one) { instance_double(Square, file: 'e', rank: '3') }
    let(:test_destination_two) { instance_double(Square, file: 'e', rank: '4') }

    before do
      location = %w[e 2]
      allow(show_moves_board).to receive(:square_at).with(location).and_return(test_start)
      allow(test_start).to receive(:highlight_blue)
      allow(test_start).to receive(:all_destinations).with(show_moves_board)
                                                     .and_return([%w[e 3], %w[e 4]])
      allow(show_moves_board).to receive(:no_check_after?).and_return(true, true)
      valids = [%w[e 3], %w[e 4]]
      allow(show_moves_board).to receive(:squares_at).with(valids)
                                                     .and_return([test_destination_one, test_destination_two])
      allow(test_destination_one).to receive(:highlight_green)
      allow(test_destination_two).to receive(:highlight_green)
      show_moves_board.show_moves_from(location)
    end

    it 'sends #highlight_blue to the square at a given location' do
      expect(test_start).to have_received(:highlight_blue)
    end

    it 'sends #highlight_green to the first valid destination square' do
      expect(test_destination_one).to have_received(:highlight_green)
    end

    it 'sends #highlight_green to the second valid destination square' do
      expect(test_destination_two).to have_received(:highlight_green)
    end
  end

  describe '#square_at' do
    subject(:square_at_board) { described_class.new }

    context 'when the given location is c5' do
      it 'returns the square at c5' do
        location = %w[c 5]
        expect([square_at_board.square_at(location).file, square_at_board.square_at(location).rank]).to eq(location)
      end
    end

    context 'when the given location is e7' do
      it 'returns the square at e7' do
        location = %w[e 7]
        expect([square_at_board.square_at(location).file, square_at_board.square_at(location).rank]).to eq(location)
      end
    end
  end

  describe '#out_of_bounds?' do
    subject(:bounds_board) { described_class.new }

    context 'when the given location is not in a standard chess board' do
      it 'returns true' do
        location = %w[e 9]
        expect(bounds_board.out_of_bounds?(location)).to be(true)
      end
    end

    context 'when the given location is in a standard chess board' do
      it 'returns false' do
        location = %w[c 5]
        expect(bounds_board.out_of_bounds?(location)).to be(false)
      end
    end
  end
end
