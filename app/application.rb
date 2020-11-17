# frozen_string_literal: true

class Application
  attr_accessor :cards, :dealer, :user

  def initialize
    @cards = Cards.new
    @dealer = Dealer.new
    @user = new_user
    game
  end

  def new_user
    print 'Введите своё имя: '
    name = gets.chomp
    User.new(name)
  end

  def game
    puts '1) Начать игру '
    puts '2) Закончить игру '
    selected = gets.chomp
    case selected
    when '1' then play_game
    when '2' then exit
    else
      game
    end
  end

  def play_game
    2.times do
      take_card(user)
      take_card(dealer)
    end

    display_info
    act

    test_info
  end

  def act; end

  def take_card(player)
    cards.take_card(player)
    bet(player)
    # player.count_score
  end

  def bet(player)
    player.place_bet
  end

  # def count_score(player)
  #   player.count_score
  # end

  def display_info
    puts '================================================================='
    puts '                        Информация'
    puts '================================================================='
    puts "                            #{user.name}"
    puts '-----------------------------------------------------------------'
    puts "Карты: #{user.cards.join(', ')}"
    puts "Очки: #{user.count_score}"
    puts "Карты Диллера: #{dealer.cards.map { 'X' }.join(', ')}"
    puts "Очки: #{dealer.count_score}"
    puts '================================================================='
  end

  def test_info
    puts '~~~~~~~~~~~~~~~'
    puts cards.deck.count.inspect
    puts user.inspect
    puts dealer.inspect
    puts '~~~~~~~~~~~~~~~'
  end
end
