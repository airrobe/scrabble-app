module Scrabble
  class CommandParsingError < StandardError; end

  class Console
    def read_input(game)
      print_welcome
      loop do
        print_state(game)
        return prompt_player
      rescue Scrabble::Error => e
        puts ''
        puts e.message
        puts ''
      rescue CommandParsingError => e
        puts e.message
        print_help
      end
    end

    def print_help
      puts "Available commands:"
      puts "- 'pass' to pass your turn"
      puts "- 'row,column word direction' to place word at coordinates row,column in direction. Examples:"
      puts "  1,3 cat horizontal"
      puts "  6,6 dog v"
      puts "- 'exit' to finish the game"
      puts ''
    end

    def print_welcome
      puts ''
      puts "Welcome to Scrabble. Type help at anytime to see available commands."
      puts ''
    end

    def print_end_game_message(game)
      print_state(game)
      winner = game.player1.score >= game.player2.score ? game.player1 : game.player2
      puts "And the winner is #{winner.id}! Thank you for playing."
    end

    def print_player_prompt(current_player)
      puts "#{current_player.id}: play your move"
    end

    def read_player_input
      case $stdin.gets.chomp
      when /(\d+),(\d+) ([a-zA-Z]+) (vertical|horizontal|h|v)/
        row = $1.to_i
        col = $2.to_i
        word = $3.upcase
        direction = parse_direction($4)
        [word, row, col, direction]
      when /pass/
        :pass
      when /help/
        :help
      when /exit/
        :exit
      else
        raise CommandParsingError.new("Could not understand your command.")
      end
    end

    def parse_direction(input)
      case input
      when 'v'
        :vertical
      when 'h'
        :horizontal
      else
        input.to_sym
      end
    end

    def print_state(game)
      print_player_table(game.player1, game.player2)
      puts ''
      print_tiles_in_bag(game.bag)
      puts ''
      print_board(game.board)
      puts ''
    end

    def print_player_table(player1, player2)
      rows = []
      player1_last_formed_words = player1.words_formed_last_turn ?
        player1.words_formed_last_turn.join(", ")
                                  : nil
      player2_last_formed_words = player2.words_formed_last_turn ?
        player2.words_formed_last_turn.join(", ")
                                  : nil
      rows << ["Player One", player1.score, player1.rack.tiles.join(","), player1_last_formed_words]
      rows << ["Player Two", player2.score, player2.rack.tiles.join(","), player2_last_formed_words]
      table = Terminal::Table.new rows: rows, headings: ["Player", "Score", "Rack", "Words formed last turn"]
      puts table
    end

    def print_board(board)
      puts "Board:"
      puts ''
      puts board.to_s
    end

    def print_tiles_in_bag(bag)
      puts "Tiles in bag: #{bag.remaining}"
    end
  end
end
