require 'hangman'

describe Hangman do
  let(:game) { Hangman.new }

  context 'when a new game is started' do

    describe '#play_game' do
      it 'prompts the user to enter yes if they are ready' do
        allow(game).to receive(:gets) { 'y' }
        expect(game.check_ready?).to eq(true)
      end

      it 'prompts the user to enter a number for the difficulty level' do
        allow(game).to receive(:gets) { '1' }
        expect(game.prompt_difficulty_selection).to eq(1)
      end

      # it 'selects a random word from the word bank that meets level condition' do 
      #   expect(game.select_word.length).to be <= 5
      # end

      # it 'creates a board with the same number of blank spaces as the word' do
      #   word = game.select_word
      #   board = game.setup_board.board
      #   expect(board.count('_')).to eq(word.length)
      # end
      
      it 'checks if the guess is valid' do
        allow(game).to receive(:gets) { 'a' }
        expect(game.get_guess).to eq('a')
        expect(game.guess_valid?).to eq(true)
      end
    end

  end
end