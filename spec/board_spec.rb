require 'board.rb'

describe Board do

  describe 'it creates an empty board with spaces for the word' do
    word = 'random'
    let(:board) { Board.new(word) }

    it 'should create an empty board with 6 spaces' do
      expect(board.board.include?('_')).to eq(true)
      expect(board.board.length).to eq(6)
    end
    
    it 'should only update the board if the letter guessed is in the word' do 
      guess = 'a'
      board.update(guess)
      expect(board.board.count('_')).to eq(5)
      expect(board.board).to eq(['_', 'a', '_', '_', '_', '_'])
    end
  end
  
end