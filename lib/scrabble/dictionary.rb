module Scrabble
  class Dictionary
    DICTIONARY_PATH = File.join(__dir__, 'dictionary.txt')

    def initialize
      @dict = File.readlines(DICTIONARY_PATH, chomp: true).each_with_object({}) do |word, dict|
        dict[word.upcase] = true
      end
    rescue SystemCallError => e
      raise e, "Error when opening dictionary file. Make sure it exists in the project's root."
    end

    def valid_word?(word)
      !!@dict[word.upcase]
    end
  end
end
