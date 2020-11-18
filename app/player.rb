# frozen_string_literal: true

class Player
  attr_accessor :name, :bank, :cards, :score

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
    @score = 0
  end

  def place_bet
    @bank -= 10
  end

  def count_score
    score = 0
    cards.map do |card|
      Cards::DECK.select do |k, v|
        next unless card.include?(k)

        score = if score + v[:value].max > 21
                  score + v[:value].min
                else
                  score + v[:value].max
                end
      end
    end
    @score = score
  end
end
