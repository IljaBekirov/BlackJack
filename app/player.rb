# frozen_string_literal: true

class Player
  attr_reader :name

  def initialize(name)
    @name = name
    @score = 100
  end
end
