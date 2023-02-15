require "./lib/game"

describe Game do
  describe "#play" do
    subject(:play_game) { described_class.new }

    before do
      allow(play_game).to receive(:turn)
    end

    context "when the game is over before a turn" do
      before do
        allow(play_game).to receive(:over?).and_return(true)
      end

      it "does not send #turn" do
        play_game.play
        expect(play_game).not_to have_received(:turn)
      end
    end

    context "when the game is not over before a turn once" do
      before do
        allow(play_game).to receive(:over?).and_return(false, true)
      end

      it "sends #turn once" do
        play_game.play
        expect(play_game).to have_received(:turn).once
      end
    end

    context "when the game is not over before a turn 3 times" do
      before do
        allow(play_game).to receive(:over?).and_return(false, false, false, true)
      end

      it "sends #turn 3 times" do
        play_game.play
        expect(play_game).to have_received(:turn).exactly(3).times
      end
    end
  end
end
