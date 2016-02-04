CARDS = [['H','1'], ['H','2'], ['H','3'], ['H','4'], ['H','5'], ['H','6'], ['H','7'], ['H','8'], ['H','9'], ['H','10'], ['H','J'], ['H','Q'], ['H','K'], 
         ['J','1'], ['J','2'], ['J','3'], ['J','4'], ['J','5'], ['J','6'], ['J','7'], ['J','8'], ['J','9'], ['J','10'], ['J','J'], ['J','Q'], ['J','K'],
         ['S','1'], ['S','2'], ['S','3'], ['S','4'], ['S','5'], ['S','6'], ['S','7'], ['S','8'], ['S','9'], ['S','10'], ['S','J'], ['S','Q'], ['S','K'],
         ['D','1'], ['D','2'], ['D','3'], ['D','4'], ['D','5'], ['D','6'], ['D','7'], ['D','8'], ['D','9'], ['D','10'], ['D','J'], ['D','Q'], ['D','K']
]

computer_card = []
player_card = []
cards = []

def total_score(card)
  total = 0
  card_value = card.map { |value| value[1]}
  card_value.each do |value| 
    if (value == 'A')
      total += 11
    elsif (value.to_i == 0)
      total += 10
    else
      total += value.to_i 
    end
  end

  card_value.select{|value| value == 'A'}.count.times do
    total -= 10 if total > 21
end

  total
end

def initialize_deck(computer_card, player_card, cards)
  empty_arr = []
  computer_card.replace(empty_arr)
  player_card.replace(empty_arr)
  cards.replace(CARDS)
end



def give_card(computer_card, player_card, cards)
    temp_comp = cards.sample(2)
    temp_comp.each {|x| cards.delete(x) }
    temp_player = cards.sample(2)
    temp_player.each {|x| cards.delete(x)} 
    temp_comp.each { |x| computer_card.insert(0,x)}
    temp_player.each {|x| player_card.insert(0,x)}
end


def give_one_card(card, card_set)
  temp_card = card_set.sample
  card_set.delete(temp_card)
  card.insert(0,temp_card)
end


def print_result(computer_card, player_card)
  print "dealer's card "
  computer_card.each { |card| print card[1] + ' ' }
  puts ''
  print "player's card "
  player_card.each { |card| print card[1] + ' ' }
  puts ''
  puts "Dealer's score is: #{total_score(computer_card)}"
  puts "Player's score is: #{total_score(player_card)}"
end




play_again =''
loop do
  initialize_deck(computer_card,player_card,cards)
  give_card(computer_card, player_card, cards)
  puts "Dealer has: #{computer_card[0][1]} and unknown card"
  puts "You have: #{player_card[0][1]} and #{player_card[1][1]}"
  answer = ''

  loop do 
    ##player turn

    loop do
    puts "Player hits or stay ? h/s"
    answer = gets.chomp
    break if (answer.downcase.start_with?('h') || answer.downcase.start_with?('s') )
    puts "Invalid input, please input again!"
    end

    puts ''

    if answer == 's' 
      puts 'You chose to stay!'
      break
    end

    give_one_card(player_card,cards) if answer == 'h' 
    if total_score(player_card) > 21
      print 'You have: '
      player_card.each { |card| print card[1] + ' ' }
      puts ''
      #puts "your score is: #{total_score(player_card)}"
      #puts "busted!!"
      break
    elsif total_score(player_card) == 21
      print 'You have: '
      player_card.each { |card| print card[1] + ' ' }
      puts ''
      #puts "your score is: #{total_score(player_card)}"
      #puts "You win!!"
      break
    else
      print 'You have: '
      player_card.each { |card| print card[1] + ' ' }
      puts ''
      puts "your score is: #{total_score(player_card)}"
    end

  end

  if total_score(player_card) > 21
    puts "-----player busted!-----"
    print_result(computer_card, player_card)
    puts '------------------------------------'
    puts "Play again? y/n"
    play_again = gets.chomp
    if play_again.downcase.start_with?('y')
      next
    else
      break
    end
  end

   ##computer turn
   computer_score = 0
   player_score = 0

  loop do 
    if (total_score(computer_card) < 17 )
      give_one_card(computer_card,cards) 
    end
    break if total_score(computer_card) >= 17
  end

  if total_score(computer_card)  > 21
    puts "-----Dealer busted!-----"
    #print "dealer's card "
    #computer_card.each { |card| print card[1] + ' ' }
    print_result(computer_card, player_card)
    puts '------------------------------------'
    puts "Play again? y/n"
    play_again = gets.chomp
    if play_again.downcase.start_with?('y')
      next
    else
      break
    end
  end  

  computer_score = total_score(computer_card)
  player_score = total_score(player_card)

  if (computer_score == 21 && player_score == 21)
    puts "-----Dealer wins!-----"
    #puts "Deal's score is: #{computer_score}"
    print_result(computer_card, player_card)
  elsif (computer_score < player_score )
    puts "-----Player wins!-----"
    #print "dealer's card "
    #computer_card.each { |card| print card[1] + ' ' }
    #puts ''
    #puts "Dealer's score is: #{computer_score}"
    print_result(computer_card, player_card)
  elsif (computer_score == player_score)
    puts "-----Tie!-----"
    #print "dealer's card "
    #computer_card.each { |card| print card[1] + ' ' }
    #puts ''
    #puts "Dealer's score is: #{computer_score}"
    print_result(computer_card, player_card)
  else
    puts "-----Dealer wins!-----"
    #print "dealer's card "
    #computer_card.each { |card| print card[1] + ' ' }
    #puts ''
    #puts "Dealer's score is: #{computer_score}"
    print_result(computer_card, player_card)
  end

  puts '------------------------------------'
  puts "Play again? y/n"
  play_again = gets.chomp
  break unless play_again.downcase.start_with?('y')

end