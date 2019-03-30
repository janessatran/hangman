# Dictionary for games
class GameDictionary

  def initialize
    @filename = './data/5desk.txt'
    set_word_length
    @dict = load_filtered_dictionary(@filename)
  end

  def set_difficulty_level(num)
    @difficulty_level = num
  end

  def load_filtered_dictionary(filename)
    File.readlines(filename).select { |line| line if line.length <= @word_length  }
  end

  def set_word_length
    if @difficulty_level == 3
      @word_length = 15
    elsif @difficulty_level == 2
      @word_length = 10
    else
      @word_length = 5      
    end
  end

  def select_random_word
    selected_word = nil
    @dict.each_with_index do |word, index|
      selected_word = word if rand < 1.0 / (index + 1)
    end
    selected_word
  end
end
