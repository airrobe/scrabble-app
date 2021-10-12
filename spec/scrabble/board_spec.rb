require 'spec_helper'
require 'scrabble/board'

RSpec.describe Scrabble::Board do
  subject { Scrabble::Board.new }

  describe '#to_s' do
    context 'when board is empty' do
      let(:expected_board) do
      <<-BOARD
     01  02  03  04  05  06  07  08  09  10  11  12  13  14  15
     _   _   _   _   _   _   _   _   _   _   _   _   _   _   _
01 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
02 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
03 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
04 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
05 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
06 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
07 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
08 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
09 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
10 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
11 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
12 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
13 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
14 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
15 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
BOARD
      end
      it 'returns a string representing an empty board' do
        expect(subject.to_s).to eq(expected_board)
      end
    end

    context 'when the board has some tiles' do
      let(:rows) do
        row =  '               '
        row3 = '        pair   '
        row4 = '        aide   '
        row5 = '    blots  a   '
        row6 = '      fitter   '
        row7 = '       nee     '
        row8 = '        r      '
        [ 
          row,  #1 
          row,  #2
          row3, #3
          row4, #4
          row5, #5
          row6, #6
          row7, #7
          row8, #8
          row,  #9
          row,  #10
          row,  #11
          row,  #12
          row,  #13
          row,  #14
          row,  #15
        ].map { |row| row.chars.map { |c| c == ' ' ? nil : c } }
      end

      subject { Scrabble::Board.new(rows) }
      let(:expected_board) {
        <<-BOARD
     01  02  03  04  05  06  07  08  09  10  11  12  13  14  15
     _   _   _   _   _   _   _   _   _   _   _   _   _   _   _
01 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
02 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
03 | _ | _ | _ | _ | _ | _ | _ | _ | p | a | i | r | _ | _ | _ |
04 | _ | _ | _ | _ | _ | _ | _ | _ | a | i | d | e | _ | _ | _ |
05 | _ | _ | _ | _ | b | l | o | t | s | _ | _ | a | _ | _ | _ |
06 | _ | _ | _ | _ | _ | _ | f | i | t | t | e | r | _ | _ | _ |
07 | _ | _ | _ | _ | _ | _ | _ | n | e | e | _ | _ | _ | _ | _ |
08 | _ | _ | _ | _ | _ | _ | _ | _ | r | _ | _ | _ | _ | _ | _ |
09 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
10 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
11 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
12 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
13 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
14 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
15 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
BOARD
      }

      it 'returns a string representing a board with tiles' do
        expect(subject.to_s).to eq(expected_board)
      end
    end
  end

  describe '#dup' do
    it 'creates an exact copy' do
      copy = subject.dup
      expect(copy.to_s).to eq(subject.to_s)
      expect(copy == subject).not_to be_truthy
    end

    it 'does not sharing underlying state' do
      rows = Array.new(15).map { Array.new(15) }
      original = Scrabble::Board.new(rows)
      copy = subject.dup
      expect(copy == subject).not_to be_truthy
      rows[0] = '        pair   '.chars.map { |c| c == ' ' ? nil : c }
      expect(copy.to_s).not_to eq(original.to_s)
    end
  end
end
