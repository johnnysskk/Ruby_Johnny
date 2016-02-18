


class Player
  attr_accessor :type , :move
  def initialize(type)
    @type = type
    @move = nil
  end 

  def choose
    if type == "player"
      choice = nil
      puts "Please enter a choice: "
      loop do 
        choice = gets.chomp
        break if ['Paper', 'Scissor', 'Rock'].include? choice
        puts "Please enter valid choice, thank you!"
      end
      self.move = choice
    else
      self.move = ['Paper', 'Scissor', 'Rock'].sample
    end
  end 
end





class RspGame
  attr_accessor :player, :computer
  def initialize
    @player = Player.new("player")
    @computer = Player.new("computer")
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
    puts "Your move is #{player_move}"
    puts "Computer's move is #{computer_move}"
    if (player_move == 'Scissor' && computer_move == 'Paper') || 
      (player_move == 'Rock' && computer_move == 'Scissor') || 
      (player_move == 'Paper' && computer_move == 'Rock')
      puts "Player wins!!"
    elsif (computer_move == 'Scissor' && player_move == 'Paper') || 
      (computer_move == 'Rock' && player_move == 'Scissor') || 
      (computer_move == 'Paper' && player_move == 'Rock')
      puts "Computer wins!!"
    else
      puts "Its a tie!!"
    end
  end

  def play
    display_welcome
    player.choose
    computer.choose
    display_winner
    display_goodbye
  end


end

RspGame.new.play