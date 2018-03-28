class Hand
  # high, pair, two pair, three of a kind, straight, flush, full house, straight-flush, royal flush
  attr_reader :cards, :suits, :values

  BEST_HANDS = [
    :royal_flush,
    :straight_flush,
    :four_of_a_kind,
    :full_house,
    :flush,
    :straight,
    :three_of_a_kind,
    :two_pair,
    :pair,
    :high_card
  ]

  def initialize(hand)
    @cards = hand
    @suits = hand.map(&:suit)
    @values = hand.map(&:value)
  end

  def best_hand
    best_hand = []
    best_hand << flush_hands if flush_hands
  end

  def straight_hands
    return :straight if straight?
    nil
  end

  def straight?
    sorted_values = values.sort
    (sorted_values.first..sorted_values.last).to_a == sorted_values
  end

  def flush_hands
    if suits.all? { |suit| suit == suits.first }
      if values.sort == (10..14).to_a
        :royal_flush
      elsif straight?
        :straight_flush
      else
        :flush
      end
    else
      nil
    end
  end

end
