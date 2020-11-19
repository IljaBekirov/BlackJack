# frozen_string_literal: true

class Interface
  def user_name
    print 'Введите своё имя: '
    gets.chomp
  end

  def ask_new_game
    puts '1) Начать игру '
    puts '2) Закончить игру '
    gets.chomp
  end

  def ask_action
    puts 'Выберите действие'
    puts '1) Пропустить'
    puts '2) Добавить карту'
    puts '3) Открыть карты'
    gets.chomp
  end

  def skip_turn(player)
    puts '================================================================='
    puts "#{player.name} пропустил ход"
  end

  def display_info(user, dealer, open)
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
    dealer_result(dealer, open)
    puts "На счету: #{dealer.bank} $"
    puts '================================================================='
  end

  def dealer_result(dealer, open)
    if open
      puts "Карты Диллера: #{dealer.cards.join(', ')}"
      puts "Очки: #{dealer.count_score}"
    else
      puts "Карты Диллера: #{dealer.cards.map { 'X' }.join(', ')}"
    end
  end

  def game_result(player)
    puts '                           Итог игры'
    puts '================================================================='
    if player
      puts "Победитель игры: #{player}"
    else
      puts 'Ничья'
    end
    puts '================================================================='
  end
end
