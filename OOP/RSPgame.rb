


class Player
  attr_accessor :move, :name
  def initialize
    set_name
  end 
end


class Human < Player

  def choose
    choice = nil
    puts "Please enter a choice: "
    loop do 
        choice = gets.chomp
        break if ['Paper', 'Scissor', 'Rock'].include? choice
        puts "Please enter valid choice, thank you!"
      end
      self.move = Move.new(choice)
  end

  def set_name
      puts 'Please enter players name: '
      name = nil
      loop do
      name = gets.chomp
      break unless name.empty?
      end
      self.name = name 
      puts "Player's name is: #{name}"
  end

end

class Computer < Player
  
  def choose
    mv = ['Paper', 'Scissor', 'Rock'].sample
    self.move = Move.new(mv)
  end

  def set_name
    self.name = ['AAA', 'BBA' ,'CCC'].sample
    puts "Computer's name is #{name}"
  end
end

class Move
  attr_accessor :value
  VALUES = ['Rock', 'Paper', 'Scissor']
  def initialize(move) 
    @value = move
  end

  def >(another_move)
    if @value == 'Scissor'
      return true if another_move.value == 'Paper'
      return false
    elsif @value == 'Paper'
      return true if another_move.value == 'Rock'
      return false
    elsif @value == 'Rock'
      return true if another_move.value == 'Scissor'
      return false
    end
  end

  def <(another_move)
    if @value == 'Scissor'
      return true if another_move.value == 'Rock'
      return false
    elsif @value == 'Paper'
      return true if another_move.value == 'Scissor'
      return false
    elsif @value == 'Rock'
      return true if another_move.value == 'Paper'
      return false
    end
  end

end



class RspGame
  attr_accessor :player, :computer
  def initialize
    @player = Human.new
    @computer = Computer.new
  end

  def display_welcome
    puts "Welcome to the world of Rock, Scissor, Paper!!"
  end

  def display_goodbye
    puts "Thanks for playing the game with us!!"
  end

  def display_winner
    player_move = player.move
    computer_move = computer.move
    puts "Your move is #{player_move.value}"
    puts "Computer's move is #{computer_move.value}"
    

    if player_move> computer_move
      puts 'Player wins!'
    elsif player_move < computer_move
      puts 'Computer wins'
    else
      puts "It's a tie!!!"
    end


    # if (player_move == 'Scissor' && computer_move == 'Paper') || 
    #   (player_move == 'Rock' && computer_move == 'Scissor') || 
    #   (player_move == 'Paper' && computer_move == 'Rock')
    #   puts "Player wins!!"
    # elsif (computer_move == 'Scissor' && player_move == 'Paper') || 
    #   (computer_move == 'Rock' && player_move == 'Scissor') || 
    #   (computer_move == 'Paper' && player_move == 'Rock')
    #   puts "Computer wins!!"
    # else
    #   puts "Its a tie!!"
    # end
  end

  def play
    display_welcome
    player.choose
    computer.choose
    display_winner
    display_goodbye
  end


end



#main
game = RspGame.new


loop do
  game.play 
  puts 'Play again? y/n'
  again = nil
  loop do 
    again = gets.chomp
    break if ['y', 'n'].include? again.downcase
    puts 'Please enter a valid input, y or n.'
  end
  break if again == 'n'
end



