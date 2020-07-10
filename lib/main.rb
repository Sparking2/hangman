require_relative 'hangman.rb'
require 'json'

# @return [HangmanGame]
def new_game 
    puts "New game started"
    puts "loading word..."
    
    dictionary = File.readlines '5desk.txt'
    dictionary.reject! {|word| word.length >= 5 && word.length <= 12 }

    clean_dictionary = dictionary[rand(0..dictionary.length)].strip

    #word load and array generation
    word = clean_dictionary.split("")
    guess_array = []
    for i in 0..(word.length - 1)
        guess_array.push ' _ '
    end
    wrong_letters = []

    hangman_game = HangmanGame.new(word,guess_array,0,wrong_letters)

    return hangman_game
end

# @return [HangmanGame]
def load_game
    file = File.read "saved_game.json"
    data = JSON.load file
    hangman_game = HangmanGame.new(data["word_array"],data["guess_array"],data["misses_count"],data["wrong_letter_array"])
    return hangman_game
end

def save_game(hangman_game)
    hash = {    'word_array' => hangman_game.word_array,
                'guess_array' => hangman_game.guess_array,
                'misses_count' => hangman_game.misses_count,
                'wrong_letter_array' => hangman_game.wrong_letter_array
    }
    File.open("saved_game.json","w") do |f|
        f.write(hash.to_json)
    end
end

#@param hangman_game[HangmanGame]
def is_game_over? hangman_game
    if hangman_game.misses_count >= 6 || (hangman_game.guess_array.join == hangman_game.word_array.join)
        true
    else
        false
    end
end

# @param letter[String]
# @param hangman_game[HangmanGame]
def guess(letter,hangman_game)

    if(letter.length > 1)
        if letter == "EXIT"
            save_game(hangman_game)
            hangman_game.misses_count =  1000
        end
    else
        if hangman_game.word_array.any?(letter)

            hangman_game.word_array.each_index do |index|
                if hangman_game.word_array[index] == letter
                    hangman_game.guess_array[index] = letter
                end
            end
        else
            hangman_game.misses_count = hangman_game.misses_count + 1
            hangman_game.wrong_letter_array.push letter
        end
    end
end


puts "Welcome to hangman, what do you want to do?"
puts "1.- Play new game"
puts "2.- Load previous game"
puts "note, when playing type EXIT to save and leave the game"

choice = gets.chomp

if(choice == "1")
    hangman_game = new_game

    until is_game_over? (hangman_game)
        #show game status
        puts "Debug --#{hangman_game.word_array}--"
        puts "Word: #{hangman_game.guess_array.join}"
        puts "#{hangman_game.misses_count} misses"
        puts "wrong letters #{hangman_game.wrong_letter_array.join}"

        #get user input
        user_input = gets.chomp
        guess(user_input,hangman_game)
    end

elsif(choice == "2")
    hangman_game = load_game
    
    until is_game_over? (hangman_game)
        #show game status
        puts "Debug --#{hangman_game.word_array}--"
        puts "Word: #{hangman_game.guess_array.join}"
        puts "#{hangman_game.misses_count} misses"
        puts "wrong letters #{hangman_game.wrong_letter_array.join}"

        #get user input
        user_input = gets.chomp
        guess(user_input,hangman_game)
    end

else
    puts "wrong option bye bye"
end

puts "Thanks for playing"


