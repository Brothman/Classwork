require 'hand'

describe Hand do
  let(:deck) { double("Deck", deal: [
                                      Card.new(:hearts, 3),
                                      Card.new(:spades, 14),
                                      Card.new(:clubs, 4),
                                      Card.new(:diamonds, 3),
                                      Card.new(:heart, 14)
                                    ]) }
  subject(:hand) { Hand.new(deck.deal) }

  let(:straight) { double("Deck", deal: [
                                      Card.new(:hearts, 3),
                                      Card.new(:spades, 5),
                                      Card.new(:clubs, 4),
                                      Card.new(:diamonds, 2),
                                      Card.new(:heart, 6)
                                    ])}
  let(:straight_hand) { Hand.new(straight.deal) }
  describe "#initialize" do
    it "sets a hand instance variable" do
      expect(hand.cards).to eq(deck.deal)
    end
  end

  describe '#best_hand' do
    it "returns the best combination of cards" do
      expect(hand.best_hand).to eq(:two_pair)
    end
  end

  describe '#flush_hands' do
    it "returns true if all cards in hand are the same suit" do
      expect(hand.flush_hands).to be nil
    end
  end

  describe '#straight_hands' do
    it "returns nil if the hand is not a straight" do
      expect(hand.straight_hands).to be nil
    end
    it "returns :straight if the hand is a straight" do
      expect(straight_hand.straight_hands).to be :straight
    end
  end

  describe '#straight?' do
    it "returns false when the card values are not in sequence with no gaps" do
      expect(hand.straight?).to be false
    end

    it "returns true when the card values are in sequence with no gaps" do
      expect(straight_hand.straight?).to be true
    end
  end

end
