class TicTacToe
  attr_accessor :board, :index
  
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
    ]
  
  def initialize(board=nil)
    @board=board || Array.new(9, " ")
  end
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(input)
    @index=input.to_i - 1
  end
  
  def move(index, token="X")
    #token=current_player
    @board[index]=token
  end
  
  def position_taken?(index)
    @board[index]==" " ? false : true
  end
  
  def valid_move?(index)
    if index.between?(0,8) && !position_taken?(index)
      true
    else
      false
    end
  end
  
  def turn_count
    @counter=0
    @board.each do |position| 
      if position == "X" || position == "O" 
        @counter+=1
      end
    end
    @counter
  end
  
  def current_player
    turn_count%2==0 ? "X" : "O"
  end
  
  def turn
    puts "Please enter 1-9"
    input=gets.strip
    index=input_to_index(input)
    if valid_move?(index)
      token=current_player
      move(index, token)
      display_board
    elsif !valid_move?(index) && !over?
      turn
    end
  end
  
  def won?
    WIN_COMBINATIONS.detect do |winning_spots|
      if winning_spots.all? {|i| @board[i]=="X"} || winning_spots.all? {|i| @board[i]=="O"}
        winning_spots
      else
        nil
      end
    end
  end
  
  def full?
    true if @board.all? {|i| i=="X" || i=="O"}
  end
  
  def draw?
    true if full? && !won?
  end
  
  def over?
    true if full? || won?
  end
  
  def winner
    if won?
      @board[won?[0]]
    end
  end
  
  def play
    while !over? && turn_count<9
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end