# frozen_string_literal: true

module Games
  # A Tic Tac Toe player
  class Player
    attr_accessor :name, :chip

    def initialize(name, chip)
      @name = name
      @chip = chip
    end
  end
end
