# frozen_string_literal: true

require 'colorize'

module Games
  # Game display
  module Display
    DEFAULT_COLOR = :light_blue

    private

    def tie_display
      puts "It's a tie!\n", :yellow
    end

    def winner_display(player_name)
      puts "Congratulations #{player_name}! You won!\n", :green
    end

    def close_game_question_display
      puts 'Press any key to play again. Or press "q" or "Q" to quit\n', :yellow
    end

    def close_display
      puts "Thanks for playing Tic Tac Toe!\n", :rainbow
      puts "Goodbye!\n"
    end

    def play_turn_display(turn, board, player_name)
      puts "Turn ##{turn}\n", :blue
      puts "#{player_name}, it's your turn!\n", :yellow
      board_display(board)
      print 'Cell: '
    end

    def invalid_play_display(cell_reference)
      puts "Invalid cell reference: #{cell_reference}\n"
      puts "Try again\n"
    end

    def board_display(board)
      board.rows.each.with_index do |row, row_index|
        row.each.with_index(row_index * 3 + 1) do |cell, cell_reference|
          print " #{cell || cell_reference} "
          print ' | ' if cell_reference % 3 != 0
        end

        puts "\n"
      end
    end

    def shuffling_players_display
      puts "Shuffling players\n", :green

      3.downto(1).each do |i|
        puts "#{i}...\n".colorize(:rainbow)
        sleep(0.5)
      end

      puts "Game Started\n", :light_magenta
    end

    def welcome_display
      puts 'Welcome to the Tic Tac Toe/n'
    end

    def setup_player_name_display(name)
      puts "Setting up #{name}\n"
      puts "Do you want to change the default name?\n"
      print "Player name (#{name}): "
    end

    def setup_confirmation_question_display(name, chip)
      puts "You're playing as #{name} with chip #{chip}\n"
      puts "Press any key to continue. Press 'n' or 'N' to restart configuration\n"
    end

    def setup_player_chip_display(chip, available_chips)
      puts "Do you want to change your chip?\n", :yellow

      available_chips.each_with_index do |available_chip, index|
        puts "#{index + 1}. #{available_chip}\n"
      end
      puts 'Select on of the chips or press enter to use your default chip\n'

      print "Player chip (#{chip}): "
    end

    def puts(message, color = DEFAULT_COLOR)
      super message.colorize(color)
    end
  end
end
