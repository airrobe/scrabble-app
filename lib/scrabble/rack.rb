require 'scrabble/game_error'
module Scrabble
  class Rack
    attr_reader :tiles

    def initialize
      @tiles = []
    end

    def add_tiles(tiles_to_add)
      raise GameError.new("cannot add tiles to exceed 7 tiles") if @tiles.size + tiles_to_add.size > 7
      @tiles += tiles_to_add
    end

    def remove_tiles(tiles_to_remove)
      tmp_tiles = @tiles.dup
      tiles_to_remove.each do |tile|
        index = tmp_tiles.index(tile)
        raise GameError.new("cannot remove tile, no more tile matching: '#{tile}' in the rack left") if index.nil?

        tmp_tiles.delete_at(index)
      end
      @tiles = tmp_tiles
    end

    def tile_count
      @tiles.size
    end
  end
end
