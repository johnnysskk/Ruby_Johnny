VALID_CHOICES = ['paper', 'scissor', 'rock', 'lizard', 'spock']

def prompt(message)
  puts ("=>#{message}")
end

def display_result(choice,computer_choice)
if (choice == 'rock' && (computer_choice == 'scissor' || computer_choice == 'lizard' ) )||
   (choice == 'scissor' && (computer_choice == 'paper' || computer_choice == 'lizard')) ||
   (choice == 'paper' && (computer_choice == 'rock' || computer_choice == 'spock')) ||
   (choice == 'lizard' && (computer_choice == 'paper' || computer_choice == 'spock')) ||
   (choice == 'spock' && (computer_choice == 'rock' || computer_choice == 'scissor'))
   prompt("You win!!")
elsif (choice == 'rock' && computer_choice == 'paper') ||
      (choice == 'scissor' && computer_choice == 'rock') ||
      (choice == 'paper' && computer_choice == 'scissor')
    prompt ("You lose!!")
else
  prompt("It's a tie!!")
end
end

play_times = 0

loop do
choice = ''
loop do
prompt("Choose paper, scissor, lizard, spock or rock!!")
choice = gets.chomp
  
  if VALID_CHOICES.include?(choice)
    break
  else
    prompt("Enter a valid choice!")
  end
end

computer_choice = VALID_CHOICES.sample
prompt("Your choice is #{choice} and computer's choice is #{computer_choice}")
display_result(choice,computer_choice)

play_times += 1
prompt("You already played #{play_times} times!")
prompt("Do you want to play again??")
result = gets.chomp
break unless result.downcase.start_with?('y')
end

prompt("Thanks for playing the game!!!")





