require 'scrabble/game'

module Scrabble
  def self.start_new_game
    Game.new.start
  end
end
