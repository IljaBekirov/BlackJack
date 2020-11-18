# frozen_string_literal: true

class Application
  attr_accessor :cards, :dealer, :user

  def initialize
    @dealer = Dealer.new
    @user = new_user
    new_game
  end

  private

  def new_user
    print 'Введите своё имя: '
    name = gets.chomp
    User.new(name)
  end

  def new_game
    clear_game
    puts '1) Начать игру '
    puts '2) Закончить игру '
    selected = gets.chomp
    case selected
    when '1' then play_game
    when '2' then exit
    else
      new_game
    end
  end

  def play_game
    2.times do
      take_card(user)
      take_card(dealer)
    end
    user.place_bet
    dealer.place_bet
    @tmp_bank = 20
    action
  end

  def action
    display_info
    puts 'Выберите действие'
    puts '1) Пропустить'
    puts '2) Добавить карту'
    puts '3) Открыть карты'
    select = gets.chomp

    case select
    when '1'
      dealer_turn
    when '2'
      take_card(user)
      dealer_turn
    when '3'
      open_card
    else
      action
    end
  end

  def dealer_turn
    if dealer.count_score > 16
      puts '================================================================='
      puts 'Диллер пропустил ход'
    else
      take_card(dealer)
    end
    action
  end

  def open_card(player = nil)
    if user.count_score == dealer.count_score
      [user, dealer].each { |pl| pl.bank += 10 }
    else
      find_winner(player).bank += @tmp_bank
    end

    display_info(true)
    game_result(player)
    new_game
  end

  def take_card(player)
    cards.take_card(player)
    open_card(player) if player.count_score > 21
  end

  def clear_game
    @cards = Cards.new
    [user, dealer].each do |player|
      player.cards = []
      player.score = 0
    end
  end

  def display_info(open = false)
    puts '================================================================='
    puts '                           Информация'
    puts '================================================================='
    puts "                            #{user.name}"
    puts '-----------------------------------------------------------------'
    puts "Карты: #{user.cards.join(', ')}"
    puts "Очки: #{user.count_score}"
    puts "На счету: #{user.bank} $"
    puts '-----------------------------------------------------------------'
    puts "                            #{dealer.name}"
    puts '-----------------------------------------------------------------'
    dealer_result(open)
    puts "На счету: #{dealer.bank} $"
    puts '================================================================='
  end

  def dealer_result(open)
    if open
      puts "Карты Диллера: #{dealer.cards.join(', ')}"
      puts "Очки: #{dealer.count_score}"
    else
      puts "Карты Диллера: #{dealer.cards.map { 'X' }.join(', ')}"
    end
  end

  def game_result(player = false)
    puts '                           Итог игры'
    puts '================================================================='
    if player
      puts "Победитель игры: #{find_winner(player).name}"
    else
      puts 'Ничья'
    end
    puts '================================================================='
  end

  def find_winner(player)
    gamers = [user, dealer]
    if player
      gamers.delete(player)
      gamers.first
    else
      gamers.max { |a, b| a.count_score <=> b.count_score }
    end
  end
end
