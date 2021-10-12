require 'spec_helper'
require 'scrabble/dictionary'

RSpec.describe Scrabble::Dictionary do

  describe '#initialize' do
    it 'loads the dictionary' do
      expect {
         Scrabble::Dictionary.new
      }.not_to raise_error
    end
  end

  describe '#valid_word?' do
    subject { Scrabble::Dictionary.new }
    it 'returns true if the word is in the dictionary' do
      expect(subject.valid_word?('cat')).to eq(true)
    end

    it 'returns false if the word is not in the dictionary' do
      expect(subject.valid_word?('caz')).to eq(false)
    end
  end
end
