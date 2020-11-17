# frozen_string_literal: true

class Player
  attr_reader :name, :bank, :cards, :score

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
    if cards.include?('A')
      puts 'Есть ТУЗ'
    else
      cards.map { |card| Cards::DECK.select { |k, v| @score += v[:value] if card.include?(k) } }
      @score
    end
  end
end
