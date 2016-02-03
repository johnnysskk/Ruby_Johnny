cards = [['H','1'], ['H','2'], ['H','3'], ['H','4'], ['H','5'], ['H','6'], ['H','7'], ['H','8'], ['H','9'], ['H','10'], ['H','J'], ['H','Q'], ['H','K'], 
         ['J','1'], ['J','2'], ['J','3'], ['J','4'], ['J','5'], ['J','6'], ['J','7'], ['J','8'], ['J','9'], ['J','10'], ['J','J'], ['J','Q'], ['J','K'],
         ['S','1'], ['S','2'], ['S','3'], ['S','4'], ['S','5'], ['S','6'], ['S','7'], ['S','8'], ['S','9'], ['S','10'], ['S','J'], ['S','Q'], ['S','K'],
         ['D','1'], ['D','2'], ['D','3'], ['D','4'], ['D','5'], ['D','6'], ['D','7'], ['D','8'], ['D','9'], ['D','10'], ['D','J'], ['D','Q'], ['D','K']
]

computer_card = []
player_card = []

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

def initial_deck(computer_card, player_card, cards)
    temp_comp = cards.sample(2)
    temp_comp.each {|x| cards.delete(x) }
    temp_player = cards.sample(2)
    temp_player.each {|x| cards.delete(x)} 
    temp_comp.each { |x| computer_card.insert(0,x)}
    temp_player.each {|x| player_card.insert(0,x)}
end


initial_deck(computer_card, player_card, cards)
puts "Dealer has: #{computer_card[0][1]} and unknown card"
puts "You have: #{player_card[0][1]} and #{player_card[1][1]}"