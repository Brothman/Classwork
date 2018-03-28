require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    populate_deck
  end

  def populate_deck
    cards = []
    values = (2..14).to_a
    suits = [:hearts, :spades, :diamonds, :clubs]

    counter = 0

    until cards.size == 52
      cards << Card.new(suits[counter % suits.size], values[counter % values.size])
      counter += 1
    end
    @cards = cards
  end

  def shuffle
    shuffled_deck = cards.shuffle
    @cards = shuffled_deck
  end

  def deal(num)
    hand = []
    until hand.size == num
      hand << cards.pop
    end
    hand
  end
  
end
