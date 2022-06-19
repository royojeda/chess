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
end
