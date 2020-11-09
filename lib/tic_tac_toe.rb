class TicTacToe
    #initialize new board with 9 blanks spots
    def initialize(board = Array.new(9, " "))
        @board = board
    end
    
    #create a constant representing all the winning combinations
    WIN_COMBINATIONS = [
  [0,1,2], #Top row
  [3,4,5], #Middle row
  [6,7,8], #Bottom row
  [0,3,6], #Left column
  [1,4,7], #Middle column
  [2,5,8], #Right column
  [0,4,8], #Left Diagonal
  [2,4,6]  #Right Diagonal
  ]
   
  ##HELPER METHODS

  #method to display current board representation
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  #accept user input as a string, conver to one less array 
  def input_to_index(user_input)
    converted_input = (user_input.to_i) - 1
  end

  #move takes in index in the @board array that the player chooses
  def move(index, character)
    @board[index] = character
  end

  #validate if position on board is taken
  def position_taken?(index)
    if @board[index] == " " || @board[index] == "" || @board[index] == nil
      false
    else
      true
    end
  end

  #check if move is valid
  def valid_move?(index)
    if position_taken?(index) == true
      false
    elsif index.between?(0,8) && position_taken?(index) == false
      true
    end
  end

  #return the number of turns played based on @board variable
  def turn_count
    counter = 0
    @board.each do |element|
      if element == "X" || element == "O"
        counter += 1
      end
    end
    counter
  end

  #determine if it's X or O's turn
  def current_player
    if turn_count.even? #if even, it's X
      return "X"
    else
      return "O"
    end
  end

  #turn method combining other methods to validate
  def turn
    puts "Please enter 1-9:"
      userInput = gets.strip # gets the user input and calls input_to_index
      index = input_to_index(userInput)
      if !valid_move?(index) # asks for input again after a failed validation
        turn
      else # makes valid moves
        move(index, current_player)
      end
    display_board
  end

  #return false for draw, return winning combo if a win
  def won?
    WIN_COMBINATIONS.detect do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
      
      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]
      
      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      else
        false
      end
    end
  end

  #return true if every element contains an x or o
  def full?
    if @board.detect {|i| i == " " || i == nil} #if all spaces are empty or blank, return false
      return false 
    else
      return true 
    end
  end 

  #return true if board is full and not won, or false otherwise
  def draw?
    if !won? && full? #if won is false and full is true return draw
      return true
    else
      return false
    end
  end

  #return true if board has been won or full
  def over?
    if won? || draw? || full?
      return true
    else
      return false
    end
  end

  #given a winning @board, return whichever player won
  def winner
    won = won? #variable one is set to when #won? method is true
    if won != nil  #if won variable is not nil
      return @board[won[0]] #return winner based on @board[won[]] value which lists winning combonation by X/O
    end
  end

##PLAY METHOD TO RUN THE GAME:  
#   until the game is over
#     take turns
#   end
  
#   if the game was won
#     congratulate the winner
#   else if the game was a draw
#     tell the players it ended in a draw
#   end
  def play
      until over?
         current_player
         turn
      end 
      if won?
       #winner(board) == "X" || winner(board) == "O" 
         puts "Congratulations #{winner}!" 
      elsif draw?
         puts "Cat's Game!" 
      end 
   end
 
end
