# frozen_string_literal: true

require './app/player'
require './app/dealer'
require './app/cards'

class Application
  def initialize
    @new_game = new_game
  end

  def new_game
    print 'Введите своё имя: '
    name = gets.chomp
    Player.new(name)
    Cards.new
    Dealer.new
    # Player.new('name')
  end
end
