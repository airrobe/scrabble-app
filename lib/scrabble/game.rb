require 'terminal-table'
require 'scrabble/board'
require 'scrabble/dictionary'
require 'scrabble/player'
require 'scrabble/bag'
require 'scrabble/console'
require 'scrabble/game_error'

module Scrabble
  class Game
    attr_reader :current_player, :player1, :player2, :bag, :board, :passed, :game_complete

    def initialize
      @dictionary = Scrabble::Dictionary.new
      @board = Scrabble::Board.new
      @bag = Scrabble::Bag.new
      @player1 = Scrabble::Player.new("Player One", @bag)
      @player2 = Scrabble::Player.new("Player Two", @bag)
      @current_player = @player1 # keeps track of whose turn it is
      @passed = false # whether the last player to play passed
      @console = Scrabble::Console.new
    end

    def start
      @game_complete = false
      @console.print_welcome
      until @game_complete
        begin
          @console.print_state(self)
          command = prompt_current_player
          case command
          when :pass
            end_game if @passed # both players have passed

            @passed = true
            change_current_player
          when :help
            @console.print_help
          when :exit
            end_game
          else
            word, row, col, direction = command
            apply_player_move(word, row, col, direction)
            if @passed
              end_game
            else
              @current_player.refill_tiles(@bag)
            end
            change_current_player
          end
        rescue Scrabble::GameError => e
          puts ''
          puts e.message
          puts ''
        rescue CommandParsingError => e
          puts e.message
          @console.print_help
        end
      end
    end

    private

    def apply_player_move(word, row, col, direction)
      #TODO
    end

    def prompt_current_player
      @console.print_player_prompt(current_player)
      @console.read_player_input
    end

    def end_game
      @console.print_end_game_message(self)
      @game_complete = true
    end

    def change_current_player
      @current_player = @current_player == @player1 ? @player2 : @player1
    end
  end
end
