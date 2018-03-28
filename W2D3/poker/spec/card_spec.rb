require 'card'

describe Card do
  describe "#initialize" do
    subject(:card) {Card.new(:hearts, 3)}
    it "sets suit as an instance variable" do
      expect(card.suit).to be :hearts
    end
    it "sets number value as an instance variable" do
      expect(card.value).to be 3
    end
  end
end
