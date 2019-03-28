require 'game_dict'

describe GameDictionary do

  context 'after initializing a new dictionary with a difficulty level' do
    let(:easy_dict) { GameDictionary.new(1) } 
    let(:normal_dict) { GameDictionary.new(2) }

    it 'gets the difficulty level from initialization' do
      expect(easy_dict.instance_variable_defined?(:@difficulty_level)).to eq(true)
    end

    it 'sets the word length maximum for selection' do
      expect(easy_dict.instance_variable_get(:@word_length)).to eql(5)
      expect(normal_dict.instance_variable_get(:@word_length)).to eql(10)
    end

    it 'creates an array of words that match the selection criteria' do 
      expect(easy_dict.instance_variable_get(:@dict)).to be_an_instance_of(Array)
      expect(easy_dict.instance_variable_get(:@dict).length).to be > 0
    end

    it 'returns random words length 5 or smaller' do
      random_word_easy = easy_dict.select_random_word
      random_word_normal = normal_dict.select_random_word

      expect(random_word_easy.length).to eq(5)
      expect(random_word_normal.length).to eq(10)
    end

  end
end