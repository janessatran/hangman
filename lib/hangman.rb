# Hangman CLI Game
require 'game_dict'

class Hangman
  def initialize
    reset_score
    @word_bank = GameDictionary.new
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
    @selected_level = Integer(gets) rescue false
  end

  def check_valid_selection; end

  def update_petals; end

  def reset_score; end

  def play; end
end