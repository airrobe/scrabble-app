require 'spec_helper'
require 'scrabble/player'

RSpec.describe Scrabble::Player do
  let(:bag) { double('bag', :empty? => false) }

  subject { Scrabble::Player.new("Player One", bag) }

  before do
    allow(bag).to receive(:draw_tiles).and_return(['A', 'O', 'C', 'E', 'Q', 'N', 'I'])
  end

  it 'starts with a score of zero' do
    expect(subject.score).to eq 0
  end

  it 'starts with seven tiles' do
    expect(subject.rack.tiles.size).to eq 7
  end

  it 'starts with no words formed in last turn' do
    expect(subject.words_formed_last_turn).to be_nil
  end

  describe '#refill_tiles' do
    let(:player) { Scrabble::Player.new("Player One", bag) }
    before do
      tile = player.rack.tiles.last
      player.rack.remove_tiles([tile])
      allow(bag).to receive(:draw_tiles).with(7).and_return(['A', 'O', 'C', 'E', 'Q', 'N', 'I'])
      allow(bag).to receive(:draw_tiles).with(1).and_return(['X'])
    end

    it 'refills the tiles to bring it back to 7' do
      player.refill_tiles(bag)
      expect(player.rack.tiles).to eq(['A', 'O', 'C', 'E', 'Q', 'N', 'X'])
    end
  end
end
