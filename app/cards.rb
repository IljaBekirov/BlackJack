# frozen_string_literal: true

class Cards
  attr_accessor :deck

  TYPE = %w[♡ ♧ ♢ ♤].freeze
  DECK = {
    '2' => { type: TYPE, value: 2 },
    '3' => { type: TYPE, value: 3 },
    '4' => { type: TYPE, value: 4 },
    '5' => { type: TYPE, value: 5 },
    '6' => { type: TYPE, value: 6 },
    '7' => { type: TYPE, value: 7 },
    '8' => { type: TYPE, value: 8 },
    '9' => { type: TYPE, value: 9 },
    '10' => { type: TYPE, value: 10 },
    'J' => { type: TYPE, value: 10 },
    'Q' => { type: TYPE, value: 10 },
    'K' => { type: TYPE, value: 10 },
    'A' => { type: TYPE, value: [1, 10] }
  }.freeze

  def initialize
    @deck = []
    @all_cards = all_cards
  end

  private

  def all_cards
    DECK.each { |card| @deck << TYPE.map { |t| card.first.to_s + t } }
    @deck.flatten!.to_a.shuffle!
  end
end
