require "./lib/player"

describe Player do
  describe "#select_piece" do
    subject(:piece_player) { described_class.new(color: "white") }

    before do
      input = "abc123"
      allow(piece_player).to receive(:gets).and_return(input)
      allow(piece_player).to receive(:puts)
    end

    it "returns the user input as an array of chars" do
      expected = %w[a b c 1 2 3]
      expect(piece_player.select_piece).to eq(expected)
    end
  end

  describe "#choose_destination" do
    subject(:destination_player) { described_class.new(color: "white") }

    before do
      input = "XYZdef456"
      allow(destination_player).to receive(:gets).and_return(input)
      allow(destination_player).to receive(:puts)
    end

    it "returns the user input as an array of chars" do
      expected = %w[x y z d e f 4 5 6]
      expect(destination_player.choose_destination).to eq(expected)
    end
  end
end
