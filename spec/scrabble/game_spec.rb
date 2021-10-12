require 'spec_helper'
require 'scrabble/board'
require 'scrabble/dictionary'
require 'scrabble/player'
require 'scrabble/game'

RSpec.describe Scrabble::Game do
  let(:game) { Scrabble::Game.new }

  context "when player enters 'exit' command" do
    before do
      allow($stdin).to receive(:gets).and_return("exit")
    end

    it "exits the game" do
      game.start
      expect(game.passed).to be false
      expect(game.game_complete).to eq true
    end

    it 'starts the game with player 1' do
      game.start
      expect(game.current_player).to eq game.player1
    end
  end

  context "when player enters an invalid command" do
    before do
      allow($stdin).to receive(:gets).and_return("3,5 horizontal 7", "exit")
    end

    it "prompts the same player again" do
      game.start
      expect(game.current_player).to eq game.player1
      expect(game.passed).to be false
    end
  end

  context "when player plays a valid word" do
    let(:rack_player_one) { double(tiles: ['A', 'T', 'I', 'L', 'C', 'O', 'Q']) }

    before do
      allow($stdin).to receive(:gets).and_return("3,5 tail vertical", "exit")
    end

    it "places the word on the board and updates the game state" do
      #TODO
    end
  end

  context "when player one passes" do
    before do
      allow($stdin).to receive(:gets).and_return("pass", "exit")
    end

    it "gives player two a chance to play their last turn" do
      game.start
      expect(game.passed).to be true
      expect(game.current_player).to eq game.player2
    end

    context "after player two plays" do
      before do
        allow($stdin).to receive(:gets).and_return("pass", "3,3 die h")
      end

      it "ends the game" do
        expect(game).to receive(:apply_player_move)
        game.start
        expect(game.passed).to be true
        expect(game.current_player).to eq game.player1
      end
    end
  end

end
