module Scrabble
  class Board
    def initialize(rows = nil)
      @rows = rows || Array.new(15).map { Array.new(15) }
    end

    def make_move(word, row, col, direction)
      #TODO: validate the move is valid
      #TODO: apply the move to the board
    end

    # creates a deep-copy of the board
    def dup
      new_rows = Array.new(15).map.with_index do |row, row_idx|
        source_row = @rows[row_idx]
        row = Array.new(15).map.with_index do |cell, col_idx|
          source_row[col_idx]
        end
      end
      Board.new(new_rows)
    end

    def to_s
      column_numbers = "     01  02  03  04  05  06  07  08  09  10  11  12  13  14  15"
      separator      = "     _   _   _   _   _   _   _   _   _   _   _   _   _   _   _"
      lines = [column_numbers, separator]
      @rows.each_with_index.map do |row, i|
        row_num = '%02.0f' % (i + 1)
        lines << "#{row_num} #{row_data(row)}" 
      end
      lines.join("\n") + "\n"
    end

    def at(position)
      board[position.row][position.column]
    end

    private

    def row_data(row)
      data = row.map { |cell| cell.nil? ? ' _ ' : " #{cell} " }
      '|' + data.join(('|')) + '|'
    end

    def valid_move?(word, row, col, direction)
      #TODO: validation rules are as follows: 
      # - is a dictionary word
      # - connected to existing letter
      # - is not trying to replace an existing letter on the board
      # - empty cell in the direction of the word at both ends (or the edge of the board)
      # - no need to check the other direction is a valid word
      true
    end
  end
end
