class Board
  attr_reader :board
  def initialize(word)
    @word = word
    @board = Array.new(word.length, '_')
  end

  def display
    print board.join(" ")
  end

  def update(guess)
    @word.each_char.with_index { |letter, index| board[index] = letter if letter == guess}
  end
end