# frozen_string_literal: true

class Application
  attr_accessor :cards, :dealer, :user

  def initialize
    @dealer = Dealer.new
    @user = User.new(Interface.new.user_name)
    new_game
  end

  private

  def new_game
    clear_game
    case Interface.new.ask_new_game
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
    Interface.new.display_info(user, dealer, false)

    case Interface.new.ask_action
    when '1'
      Interface.new.skip_turn(user)
      dealer_turn
    when '2'
      take_card(user)
      dealer_turn
    when '3'
      open_card(nil)
    else
      action
    end
  end

  def dealer_turn
    dealer.count_score > 16 ? Interface.new.skip_turn(dealer) : take_card(dealer)
    action
  end

  def open_card(player)
    winner_name = if user.count_score == dealer.count_score
                    [user, dealer].each { |pl| pl.bank += 10 }
                    nil
                  else
                    winn = find_winner(player)
                    winn.bank += @tmp_bank
                    winn.name
                  end

    Interface.new.display_info(user, dealer, true)
    Interface.new.game_result(winner_name)
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

  def find_winner(player)
    gamers = [user, dealer]
    return gamers.max { |a, b| a.count_score <=> b.count_score } unless player

    gamers.delete(player)
    gamers.first
  end
end
