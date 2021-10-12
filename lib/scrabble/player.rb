require 'scrabble/rack'

module Scrabble
  class Player
    attr_reader :id, :rack, :words_formed_last_turn, :score

    def initialize(id, bag)
      @score = 0
      @id = id
      @rack = Rack.new
      @rack.add_tiles(bag.draw_tiles(7))
      @words_formed_last_turn = nil
    end

    def make_move(move, board)
      #TODO
    end

    def refill_tiles(bag)
      rack.add_tiles(bag.draw_tiles(7 - rack.tile_count))
    end

    private

    def score_words(words)
      score += words.map(&:size).reduce(:+)
    end

    def invalid_move_error(move)
      GameError.new("Player: #{id} cannot make the move because their rank does not have required tiles: #{move.letters}")
    end
  end
end
