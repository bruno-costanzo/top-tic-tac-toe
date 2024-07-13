# frozen_string_literal: true

require_relative './games/player'
require_relative './games/board'
require_relative './games/display'

# A Tic Tac Toe game
class Game
  include Games::Display
  CHIPS = ['🔥', '🐙', '🐒', '🐪', '🦊', '🦓'].freeze

  DEFAULT_CONFIGURATION = {
    player_one: ['player_one', '🐺'],
    player_two: ['player_two', '🐙']
  }.freeze

  def self.start
    new(
      Games::Player.new(*DEFAULT_CONFIGURATION[:player_one]),
      Games::Player.new(*DEFAULT_CONFIGURATION[:player_two]),
      Games::Board.new
    ).run
  end

  def initialize(player_one, player_two, board)
    @player_one = player_one
    @player_two = player_two
    @board = board
    @turn = 0
  end

  def run
    setup
    play
    close
  end

  private

  def close
    close_display
  end

  def setup
    welcome_display

    players.each { |player| setup_player player }
  end

  def setup_player(player)
    loop do
      setup_player_name player
      setup_player_chip player

      break if setup_confirmed? player
    end
  end

  def setup_player_name(player)
    setup_player_name_display(player.name)

    inserted_name = gets.chomp

    player.name = inserted_name unless inserted_name.empty?
  end

  def setup_player_chip(player)
    chips = available_chips

    setup_player_chip_display(player.chip, chips)

    inserted_chip_index = (gets.chomp.to_i - 1)

    player.chip = chips[inserted_chip_index] if (0..chips.length - 1).include?(inserted_chip_index)
  end

  def setup_confirmed?(player)
    setup_confirmation_question_display(player.name, player.chip)

    player_response = gets.chomp

    %w[N n].all? { |negative| negative != player_response }
  end

  def available_chips
    @available_chips ||= CHIPS.reject { |chip| players.any? { |player| player.chip == chip } }
  end

  def players
    @players ||= [@player_one, @player_two]
  end

  def play
    loop do
      shuffling_players_display

      @players = @players.shuffle

      match

      break if close_game?

      @board = Games::Board.new
    end
  end

  def close_game?
    close_game_question_display

    user_entry = gets.chomp

    %w[q Q].include?(user_entry)
  end

  def match
    @turn = 0

    loop do
      @turn += 1

      play_turn

      break game_finished if finished?
    end
  end

  def game_finished
    case match_status
    when :winner
      winner_display(current_player.name)
    when :tie
      tie_display
    end

    board_display(@board)
  end

  def play_turn
    loop do
      play_turn_display(@turn, @board, current_player.name)

      cell_reference = gets.chomp.to_i

      (row, column) = row_and_column_from_cell_reference(cell_reference)

      break if @board.insert(row, column, current_player.chip)

      invalid_play_display(cell_reference)
    end
  end

  def row_and_column_from_cell_reference(cell_reference)
    cell_reference -= 1

    [cell_reference / 3, cell_reference % 3]
  end

  def current_player
    players[@turn % 2]
  end

  def finished?
    match_status != :running
  end

  def match_status
    return :winner if @board.tic_tac_toe?
    return :tie if @board.full?

    :running
  end
end
