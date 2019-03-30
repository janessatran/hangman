# Hangman CLI Game
require_relative 'game_dict.rb'
require_relative 'board.rb'

class Hangman
  def initialize
    @score = 0
    @guesses = 12
    @word_bank = GameDictionary.new
    play_game
  end

  def print_rules
    puts %{
        Welcome to Hangman!

        Hangman is a guessing game. I will select a random word and you
        will try to guess it, letter by letter, within 10 guesses. 
        If you are able to guess the word within 10 guesses, you win!
        If not... you lose (but you still rock! Never give up!)
    }
  end

  def check_ready?
    puts 'Are you ready to play? (Y/N)'
    user_input = gets.chomp.downcase
    return true if user_input == 'y' || user_input == 'yes'
    return false
  end

  def select_word
    @word_bank.select_random_word
  end

  def prompt_difficulty_selection
    puts %{
      Please select a mode by entering a number:
      1 - Easy
      2 - Normal
      3 - Hard
    }
    @selected_level = Integer(gets.to_i) rescue false
  end

  def guess_valid?
    @guess =~ /^[A-Z0-9]+$/i
  end

  def update_guesses_left
    @guesses =- 1
  end

  def get_guess
    @guess = gets.chomp
  end

  def game_over?
    @guesses_left == 0 || @game_board.include?('_') == false
  end

  def update_score
    @score += 1
  end

  def determine_winner
    if @guesses_left > 0 && @game_board.board.includes?('_') == false
      puts 'Woohoo! You guessed the word!'
      update_score
    else
      puts 'Better luck next time!'
    end
  end

  def play_game
    print_rules
    if check_ready? 
      @level = prompt_difficulty_selection.to_i
      @word_bank.set_difficulty_level(@level)
      @word = select_word
      @game_board = Board.new(@word)
      until game_over?
        get_guess
        if guess_valid?
          @game_board.update(@guess)
          @game_board.display
          update_guesses_left
        else
          puts 'Invalid input. Please enter a letter A through Z.'
        end
      end
      determine_winner
    end
  end

end