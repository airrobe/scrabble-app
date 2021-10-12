#!/usr/bin/env ruby
require 'spec_helper'
require 'scrabble/rack'
require 'scrabble/game_error'

RSpec.describe Scrabble::Rack do
  let(:tiles) { ['C', 'A', 'T', 'U', 'N', 'O', 'E'] }
  let(:tiles_to_remove) { ['C', 'A', 'T'] }
  let(:tiles_to_refill) { ['A', 'P', 'J']}

  subject { Scrabble::Rack.new }

  describe '#initialize' do
    it 'is empty at the start' do
      expect(subject.tiles).to eq([])
    end
  end

  describe '#add_tiles' do
    context 'when empty' do
      it 'can upto 7 tiles' do
        subject.add_tiles(tiles_to_refill)
        expect(subject.tiles).to eq(tiles_to_refill)
      end
    end

    context 'when it contains some tiles' do
      let(:initial_tiles) { ['A', 'X', 'Z', 'B'] }
      before { subject.add_tiles(initial_tiles) }
      it 'can add some to make upto 7 in total' do
        subject.add_tiles(tiles_to_refill)
        expect(subject.tiles).to eq(initial_tiles + tiles_to_refill)
      end

      it 'cannot add tiles that make total exceed 7' do
        expect {
           subject.add_tiles(tiles_to_refill + ['X'])
        }.to raise_error(Scrabble::GameError)
      end
    end
  end

  describe '#remove_tiles' do
    context 'when the rack is empty' do
      it 'raises an error' do
        expect { subject.remove_tiles(tiles_to_remove) }.to raise_error(Scrabble::GameError)
      end
    end

    context 'when tiles exists in the rack' do
      before { subject.add_tiles(tiles) }
      it 'removes them successfully and correct number of tiles remain' do
        subject.remove_tiles(tiles_to_remove)
        expect(subject.tiles).to eq(['U', 'N', 'O', 'E'])
      end
    end

    context 'when tiles does not exist in the rack' do
      before { subject.add_tiles(tiles) }
      it 'raises error and not modify the rack contents' do
        expect {
           subject.remove_tiles(['D', 'O', 'G'])
        }.to raise_error(Scrabble::GameError)
        expect(subject.tiles).to eq(tiles)
      end
    end
  end
end
