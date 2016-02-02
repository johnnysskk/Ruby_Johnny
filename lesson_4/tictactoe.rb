# Tic tac toe program

require 'pry'


INITIAL_MARKER =' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def display_board(board)
  system 'cls'
  puts ""
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}  "
  puts "     |     |"
  puts ""
end


def initialize_board 
  new_board = {}
  (1..9).each{|num| new_board[num] = INITIAL_MARKER}
  new_board
end

def prompt(message)
  puts "=>#{message}"
end

def empty_place(board)
  board.select{|key,value| value == INITIAL_MARKER}
end


def player_place_item(board)
  place = ''
  loop do 
   prompt("Please choose a place to put! #{empty_place(board).keys.join(', ')}")
   place = gets.chomp.to_i
   if empty_place(board).include?(place)
    break
   else
    prompt("Please enter a valid place!!")
   end
  end
  board[place] = PLAYER_MARKER
end


def computer_place_item(board)
  board[empty_place(board).keys.sample] = COMPUTER_MARKER
end

def someone_win?(board) 
  !!detect_winner(board)
end

def detect_winner(board)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9]] +  #row
                  [[1,4,7], [2,5,8], [3,6,9]] +  #column
                  [[1,5,9], [3,5,7]]             #diagonal
  winning_lines.each do |line|
      if board[line[0]]== PLAYER_MARKER &&
         board[line[1]]== PLAYER_MARKER &&
         board[line[2]]== PLAYER_MARKER
         return 'Player'
      elsif board[line[0]]== COMPUTER_MARKER &&
         board[line[1]]== COMPUTER_MARKER &&
         board[line[2]]== COMPUTER_MARKER
         return 'Computer'
      end
  end
  return nil
end



def board_full?(board)
  empty_place(board).keys == []  # see if it is empty
end



loop do

board = initialize_board
display_board(board)

loop do
  display_board(board)

  player_place_item(board)
  display_board(board)
  break if someone_win?(board) || board_full?(board)

  computer_place_item(board)
  display_board(board)
  break if someone_win?(board) || board_full?(board)
end

if someone_win?(board)
  prompt("#{detect_winner(board)}  won!!")
else
  prompt("It's a tie!")
end

prompt("Play again??")
answer = gets.chomp
break unless answer.downcase.start_with?('y')
end


prompt("Thanks for playing the game!!!")