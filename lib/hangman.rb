# Hangman CLI Game
require_relative 'game_dict.rb'
require_relative 'board.rb'
require 'yaml'


class Hangman
  def initialize
    @score = 0
    @guesses = 12
    @guessed_letters = []
    menu
    # play_game
  end

  def print_rules
    puts %{
        Welcome to Hangman!

        Hangman is a guessing game. I will select a random word and you
        will try to guess it, letter by letter, within 12 guesses. 
        If you are able to guess the word within 12 guesses, you win!
        If not... you lose (but you still rock! Never give up!)
    }
  end

  def load_file(selection)
    saved_game = YAML::load(File.read("saved_games/game_#{selection}.yaml"))
    saved_game.play_game
  end

  def menu
    print_rules
    if check_ready? 
      puts "Press 0 to start a new game or enter a number from the list below to load a saved game."
      Dir.exists?("saved_games") ? (puts Dir["saved_games/*"]) : (puts "No saved games!  Please press 0.")
      selection = gets.chomp
      count_saved_games = Dir[File.join("saved_games", '**', '*')].count { |file| File.file?(file) }
      until ("0"..count_saved_games.to_s).include?(selection)
        puts "Invalid input or game not found. Please enter 0 for a new game."
        selection = gets.chomp
      end
      selection == "0" ? setup_game : load_file(selection)
    end
  end

  def save_game
    Dir.mkdir("saved_games") unless Dir.exists? ("saved_games")
    count = Dir[File.join("saved_games", '**', '*')].count { |file| File.file?(file) }
    File.open("saved_games/game_#{count + 1}.yaml", "w") do |out|
      YAML.dump(self, out)
    end
  end

  def check_ready?
    puts 'Are you ready to play? (Y/N)'
    user_input = gets.chomp.downcase
    return true if user_input == 'y' || user_input == 'yes'
    return false
  end

  def select_word
    puts 'Selecting a word...'
    sleep 0.5
    @word = @word_bank.select_random_word
  end

  def prompt_difficulty_selection
    puts %{
      Please select a mode by entering a number:
      1 - Easy
      2 - Normal
      3 - Hard
    }
    @selected_level = Integer(gets.chomp) rescue false
  end

  def level_valid?
    @selected_level.to_i >= 1 || @selected_level.to_i <= 3
  end

  def guess_valid?
    (@guess =~ /^[A-Z0-9]+$/i && @guess.length == 1) 
  end

  def update_guesses_left
    @guesses -= 1
    puts "Guesses left: #{@guesses}"
  end

  def get_input
    puts 'Please enter a letter A through Z to guess, or press 1 to save and exit the game.'
    @guess = gets.chomp.downcase
    if @guess == "1"
      save_game
      exit
    end
  end

  def game_over?
    @guesses <= 0 || @game_board.complete?
  end

  def update_score
    @score += 1
  end

  def determine_winner
    if @guesses > 0 && @game_board.complete?
      puts 'Woohoo! You guessed the word!'
      update_score
    else
      puts "The word was #{@word}."
      puts 'Better luck next time!'
      puts ''
    end
  end

  def update_guessed_letters
    @guessed_letters << @guess
  end

  def setup_board
    @game_board = Board.new(@word)
  end

  def setup_game
    prompt_difficulty_selection
    if level_valid?
      @word_bank = GameDictionary.new(@selected_level)
      select_word
      setup_board
      play_game
    else
      puts 'Invalid input. Please enter a number 1, 2, or 3.'
    end
  end

  def play_game
    @game_board.display
    until game_over?
      get_input
      if guess_valid?
        update_guessed_letters
        @game_board.update(@guess)
        @game_board.display
        puts "guessed letters: #{@guessed_letters}"
        update_guesses_left
      else
        puts 'Invalid input. Please enter a letter A through Z.'
      end
    end
    determine_winner
  end

end

game = Hangman.new
