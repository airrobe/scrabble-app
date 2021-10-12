require 'spec_helper'
require 'scrabble/bag'

RSpec.describe 'Bag' do
  subject { Scrabble::Bag.new }

  describe '#draw_tile' do
    context 'when bag is not empty' do
      it 'draws a tile from the bag' do
        tile = subject.draw_tile
        expect('A'..'Z').to include tile
      end
    end

    context 'when bag is empty' do
      before { 100.times { |_| subject.draw_tile } }

      it 'returns nil' do
        expect(subject.draw_tile).to be nil
      end
    end

    context 'distribution' do
      let(:expected_distribution) do
        {
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
      end

      it 'draws tiles obeying the expected distribution' do
        actual_distribution = 100.times.each_with_object(Hash.new(0)) do |_, dist|
          tile = subject.draw_tile
          dist[tile] += 1
        end

        expect(actual_distribution).to eq expected_distribution
      end
    end
  end
  
  describe '#draw_tiles' do
    it 'draws the number of tiles from the bag' do
      tiles = subject.draw_tiles(7)
      expect(tiles).not_to be_nil
      expect(tiles.size).to eq 7
    end
  end

  describe '#empty?' do
    context 'when bag is not empty' do
      it 'returns false' do
        expect(subject.empty?).to be false
      end
    end

    context 'when bag is empty' do
      before { 100.times { |_| subject.draw_tile } }

      it 'returns true' do
        expect(subject.empty?).to be true
      end
    end
  end

  describe 'remaining' do
    it 'returns the amount of tiles in the bag' do
      expect(subject.remaining).to be 100
      20.times{ |_| subject.draw_tile }
      expect(subject.remaining).to be 80
      80.times{ |_| subject.draw_tile }
      expect(subject.remaining).to be 0
    end
  end
end
