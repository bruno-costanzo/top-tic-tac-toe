# frozen_string_literal: true

module Games
  # Tic Tac Toe Board
  class Board
    attr_accessor :rows

    def initialize
      @rows = Array.new(3) { Array.new(3) { nil } }
    end

    def tic_tac_toe?
      (rows + columns + diagonals).any? { |combination| winner_combination? combination }
    end

    def full?
      rows.flatten.none?(&:nil?)
    end

    def insert(row, column, chip)
      return false unless valid_insert?(row, column)

      @rows[row][column] = chip
    end

    private

    def valid_insert?(row, column)
      return false if row.negative? || row > 2 || column.negative? || column > 2

      rows[row][column].nil?
    end

    def winner_combination?(combination)
      return false if combination.any?(&:nil?)

      combination.uniq.length == 1
    end

    def diagonals
      [
        [rows[0][0], rows[1][1], rows[2][2]],
        [rows[0][2], rows[1][1], rows[2][0]]
      ]
    end

    def columns
      @rows.transpose
    end
  end
end
