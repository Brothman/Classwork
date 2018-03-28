require 'deck'

describe Deck do
  subject(:deck) {Deck.new}
  describe "#initialize" do # just doing this because we learned it and it is coolio
    it "calls the populate deck method" do
      fake_deck = Deck.allocate
      expect(fake_deck).to receive(:populate_deck)
      fake_deck.send(:initialize)
    end

    it "initialized deck instance variable is 52 cards long" do
      expect(deck.cards.size).to be 52
    end
  end

  describe "#populate_deck" do
    it "generates 52 Card class objects and inserts them into a deck variable" do
      expect(deck.cards.all? {|card| card.is_a?(Card)}).to be true
    end
  end

  describe "#shuffle" do
    it "shuffles the deck :O" do
      unshuffled_deck = deck.cards
      deck.shuffle
      shuffled_deck = deck.cards
      expect(shuffled_deck).to_not eq(unshuffled_deck)
    end
  end

  describe "#deal" do
    it "removes N cards from the deck" do
      deck.deal(5)
      expect(deck.cards.size).to be 47
    end
    it "returns an array of N length" do
      expect(deck.deal(5).length).to be 5
    end
    it "returns an array of cards" do
      expect(deck.deal(5).all? { |card| card.is_a?(Card)}).to be true
    end
  end
end
