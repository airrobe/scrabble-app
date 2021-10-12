module Scrabble
  class GameError < StandardError
    def to_s
      "Error: " + super.to_s
    end
  end
end
