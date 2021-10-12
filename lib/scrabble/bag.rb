module Scrabble
  class Bag
    DISTRIBUTION = {
      # Defines how many of each tile the bag starts with.
      # Taken from: https://scrabble.hasbro.com/en-us/faq#:~:text=How%20many%20of%20each%20letter,of%20all%20the%20Scrabble%20tiles%3F
      # The original rules include 2 blank tiles which we won't be using, so I added an extra 'A'
      # and 'O' tiles, since they were among the most common letters already, in order to get
      # the 100 required by the problem description.
      'A' => 10,
      'B' => 2,
      'C' => 2,
      'D' => 4,
      'E' => 12,
      'F' => 2,
      'G' => 3,
      'H' => 2,
      'I' => 9,
      'J' => 1,
      'K' => 1,
      'L' => 4,
      'M' => 2,
      'N' => 6,
      'O' => 9,
      'P' => 2,
      'Q' => 1,
      'R' => 6,
      'S' => 4,
      'T' => 6,
      'U' => 4,
      'V' => 2,
      'W' => 2,
      'X' => 1,
      'Y' => 2,
      'Z' => 1
    }

    def initialize
      @tiles = generate_tiles
    end

    def draw_tile
      @tiles.delete_at(rand @tiles.length)
    end

    def draw_tiles(count)
      tiles = []
      while !empty? && count > 0
        tiles << draw_tile
        count -= 1
      end
      tiles
    end

    def empty?
      @tiles.empty?
    end

    def remaining
      @tiles.size
    end

    private

    def generate_tiles
      DISTRIBUTION.reduce([]) do |tiles, (letter, amount)|
        tiles + Array.new(amount, letter)
      end
    end
  end
end
