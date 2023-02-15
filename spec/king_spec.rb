require "./lib/Pieces/king"
require "./lib/board"

describe King do
  describe "#moves" do
    subject(:move_king) { described_class.new(color: "white") }

    it "returns an array of all proper king moves" do
      expected = [[[0, 1]], [[1, 1]], [[1, 0]], [[1, -1]], [[0, -1]], [[-1, -1]], [[-1, 0]], [[-1, 1]]].sort
      expect(move_king.moves.sort).to eq(expected)
    end
  end

  describe "#specials" do
    subject(:special_king) { described_class.new(color: "white") }

    it "returns the castling moves" do
      expected = [[2, 0], [-2, 0]].sort
      expect(special_king.specials.sort).to eq(expected)
    end
  end

  describe "#special_allowed?" do
    subject(:allowed_king) { described_class.new(color: "white") }

    let(:test_board) { instance_double(Board) }

    before do
      allow(allowed_king).to receive(:destination_from)
      allow(allowed_king).to receive(:locations_between_king_and_rook)
      allow(allowed_king).to receive(:locations_in_king_path)
      allow(allowed_king).to receive(:rook_square)
    end

    context "when all conditions for castling are met" do
      before do
        allow(allowed_king).to receive(:first_move).and_return(true)
        allow(test_board).to receive(:check?).and_return(false)
        allow(test_board).to receive(:all_empty?).and_return(true)
        allow(test_board).to receive(:none_attacked?).and_return(true)
        allow(test_board).to receive(:can_castle?).and_return(true)
      end

      it "returns true" do
        special = [2, 0]
        expect(allowed_king.special_allowed?(special, test_board)).to be(true)
      end
    end

    context "when the king has already moved before" do
      before do
        allow(allowed_king).to receive(:first_move).and_return(false)
        allow(test_board).to receive(:check?).and_return(false)
        allow(test_board).to receive(:all_empty?).and_return(true)
        allow(test_board).to receive(:none_attacked?).and_return(true)
        allow(test_board).to receive(:can_castle?).and_return(true)
      end

      it "returns false" do
        special = [2, 0]
        expect(allowed_king.special_allowed?(special, test_board)).to be(false)
      end
    end

    context "when the king is in check" do
      before do
        allow(allowed_king).to receive(:first_move).and_return(true)
        allow(test_board).to receive(:check?).and_return(true)
        allow(test_board).to receive(:all_empty?).and_return(true)
        allow(test_board).to receive(:none_attacked?).and_return(true)
        allow(test_board).to receive(:can_castle?).and_return(true)
      end

      it "returns false" do
        special = [2, 0]
        expect(allowed_king.special_allowed?(special, test_board)).to be(false)
      end
    end

    context "when there are other pieces between the king and rook" do
      before do
        allow(allowed_king).to receive(:first_move).and_return(true)
        allow(test_board).to receive(:check?).and_return(false)
        allow(test_board).to receive(:all_empty?).and_return(false)
        allow(test_board).to receive(:none_attacked?).and_return(true)
        allow(test_board).to receive(:can_castle?).and_return(true)
      end

      it "returns false" do
        special = [2, 0]
        expect(allowed_king.special_allowed?(special, test_board)).to be(false)
      end
    end

    context "when the squares on the king's path are attacked" do
      before do
        allow(allowed_king).to receive(:first_move).and_return(true)
        allow(test_board).to receive(:check?).and_return(false)
        allow(test_board).to receive(:all_empty?).and_return(true)
        allow(test_board).to receive(:none_attacked?).and_return(false)
        allow(test_board).to receive(:can_castle?).and_return(true)
      end

      it "returns false" do
        special = [2, 0]
        expect(allowed_king.special_allowed?(special, test_board)).to be(false)
      end
    end

    context "when there is no rook, on the appropriate spot, that can castle" do
      before do
        allow(allowed_king).to receive(:first_move).and_return(true)
        allow(test_board).to receive(:check?).and_return(false)
        allow(test_board).to receive(:all_empty?).and_return(true)
        allow(test_board).to receive(:none_attacked?).and_return(true)
        allow(test_board).to receive(:can_castle?).and_return(false)
      end

      it "returns false" do
        special = [2, 0]
        expect(allowed_king.special_allowed?(special, test_board)).to be(false)
      end
    end
  end
end
