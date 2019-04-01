require 'game_dict'

describe GameDictionary do

  context 'after initializing a new dictionary with a difficulty level' do
    let(:easy_dict) { GameDictionary.new(1) } 
    let(:normal_dict) { GameDictionary.new(2) }
    let(:hard_dict) { GameDictionary.new(3) }

    it 'sets the word length maximum for selection' do
      # easy_dict.set_difficulty_level(1)
      # normal_dict.set_difficulty_level(2)
      # hard_dict.set_difficulty_level(3)
  
      expect(easy_dict.instance_variable_get(:@word_length)).to eql(5)
      expect(normal_dict.instance_variable_get(:@word_length)).to eql(10)
      expect(hard_dict.instance_variable_get(:@word_length)).to eql(15)

    end

    it 'creates an array of words that match the selection criteria' do 
      expect(easy_dict.instance_variable_get(:@dict)).to be_an_instance_of(Array)
      expect(easy_dict.instance_variable_get(:@dict).length).to be > 0
    end

    it 'returns random words with length limited by difficulty level' do
      random_word_easy = easy_dict.select_random_word
      random_word_normal = normal_dict.select_random_word
      random_word_hard = hard_dict.select_random_word
      
      expect(random_word_easy.length).to be <= 5
      expect(random_word_normal.length).to be <= 10 
      expect(random_word_hard.length).to be <= 15

    end

  end
end