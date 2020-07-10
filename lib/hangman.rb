class HangmanGame

    attr_accessor :misses_count
    attr_accessor :guess_array
    attr_accessor :wrong_letter_array
    attr_reader :word_array

    #@param word_array[Array]
    #@param guess_array[Array]
    #@param misses_count[Integer]
    #@param wrong_letter_array[Array]
    def initialize (word_array = ["e","a","s","y"],guess_array = ["_","_","_","_"], misses_count = 0, wrong_letter_array = [])
        @word_array = word_array
        @guess_array = guess_array
        @misses_count = misses_count
        @wrong_letter_array = wrong_letter_array
    end

end