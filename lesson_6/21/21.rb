require 'pry'
SUITS = ['Spades', 'Clubs', 'Diamonds', 'Hearts']
FACES = ['Jack', 'Queen', 'King', 'Ace']
GOAL = 21
DEALER_CAP = 17
ROUNDS_TO_WIN = 1

def initialize_deck
  deck = []

  SUITS.each do |suit|
    (2..10).each do |number|
      deck << { suit: suit, value: number }
    end
    FACES.each do |face|
      deck << { suit: suit, value: face }
    end
  end
  deck
end

def initialize_round
  hands = { dealer: { cards: [], total: 0 },
            player: { cards: [], total: 0 } }
  deck = initialize_deck
  return deck, hands
end

def opening_hands(deck, hands)
  2.times do
    draw_card!(deck, hands, :player)
    draw_card!(deck, hands, :dealer)
  end
end

def display_drawn_card(card, current_player)
  puts `clear`
  puts "#{current_player.capitalize} drew #{card[:value]} of #{card[:suit]}"
  sleep(2)
end

def draw_card!(deck, hands, current_player)
  card = ''
  current_hand = hands[current_player]
  loop do
    card = deck.sample
    delt = hands[:player][:cards] + hands[:dealer][:cards]
    break unless delt.include?(card)
  end
  current_hand[:cards] << card
  current_hand[:total] = hand_total(current_hand[:cards])
  card
end

def hand_total(hand)
  aces = 0
  total = 0

  hand.each do |card|
    total = if ace_card?(card)
              aces += 1
              total + 11
            elsif face_card?(card)
              total + 10
            else
              total + card[:value]
            end
  end
  adjust_aces(total, aces)
end

def ace_card?(card)
  card[:value] == 'Ace'
end

def face_card?(card)
  FACES[0, 3].include?(card[:value])
end

def adjust_aces(total, aces)
  aces.times do
    total -= 10 if total > GOAL
  end
  total
end

def hit_or_stay
  loop do
    puts "Hit or stay? (Type selection below)"
    print "=>"
    choice = gets.chomp.downcase
    break choice if ["hit", "h", "stay", "s"].include?(choice)
    puts "please try again"
  end
end

def display_hands(hands, show_dealer_hand=false)
  puts `clear`
  hands.each_pair do |holder, hand|
    formatted_cards = format_card_display(hand[:cards])
    puts "#{holder.to_s.capitalize} has:"
    if holder == :dealer && !show_dealer_hand
      puts formatted_cards[0]
      puts "And an unknown card"
    else
      puts formatted_cards
      puts "TOTAL: #{hand[:total]}"
    end
    puts "\n"
  end
end

def format_card_display(hand)
  card_array = []
  hand.each do |card|
    card_array << "#{card[:value]} of #{card[:suit]}"
  end
  card_array
end

def players_turn(hands, deck)
  display_hands(hands)
  loop do
    if ["stay", "s"].include?(hit_or_stay)
      break
    else
      card = draw_card!(deck, hands, :player)
      display_drawn_card(card, "player")
      display_hands(hands)
      sleep(1)
      break if hands[:player][:total] > GOAL
    end
  end
end

def dealers_turn(hands, deck)
  display_hands(hands, true)
  sleep(1)
  while hands[:dealer][:total] < DEALER_CAP
    card = draw_card!(deck, hands, :dealer)
    display_drawn_card(card, "dealer")
    display_hands(hands, true)
    sleep(1)
  end
end

def display_bust(current_player)
  puts "#{current_player.capitalize} busted!"
  sleep(2)
end

def player_busted?(hand)
  hand[:total] > GOAL
end

def end_round_sequence(scores, hands, winner=nil)
  winner = detect_winner(hands) if !winner
  display_round_winner(winner)
  scores[winner.to_sym] += 1 unless winner == "tie"
end

def detect_winner(hands)
  if hands[:player][:total] > hands[:dealer][:total]
    "player"
  elsif hands[:player][:total] < hands[:dealer][:total]
    "dealer"
  else
    "tie"
  end
end

def display_round_winner(winner)
  puts `clear`
  if winner != "tie"
    puts "#{winner.capitalize} won the round"
  else
    puts "It's a tie!"
  end
  sleep(2)
end

def play_again?
  puts `clear`
  answer = ''
  loop do
    puts "Play again? Yes/No"
    print "=>"
    answer = gets.chomp.downcase
    break if ['yes', "y", "n", "no"].include?(answer)
    puts "please try again"
  end
  return true if ['yes', 'y'].include?(answer)
end

def display_change_turn
  puts `clear`
  puts "Dealers turn"
  sleep 2
end

def display_intro
  puts `clear`
  puts "Welcome to #{GOAL}!"
  sleep(1.5)
end

def display_outro
  puts `clear`
  puts 'Thanks for playing 21!'
  sleep(1.5)
  puts `clear`
end

def display_game_winner(scores)
  puts `clear`
  game_winner = scores.key(ROUNDS_TO_WIN).to_s.capitalize
  puts "#{game_winner} won the Game"
  sleep(2)
end

def display_scores(scores)
  puts `clear`
  puts "SCORES - Player: #{scores[:player]} Dealer: #{scores[:dealer]}"
  sleep(2)
end

display_intro
loop do
  scores = { dealer: 0, player: 0 }
  loop do
    display_scores(scores)
    break if scores.value?(ROUNDS_TO_WIN)
    deck, hands = initialize_round
    opening_hands(deck, hands)
    players_turn(hands, deck)
    if player_busted?(hands[:player])
      display_bust(:player)
      end_round_sequence(scores, hands, :dealer)
      next
    end
    display_change_turn
    dealers_turn(hands, deck)
    if player_busted?(hands[:dealer])
      display_bust(:dealer)
      end_round_sequence(scores, hands, :player)
      next
    end
    end_round_sequence(scores, hands)
  end
  display_game_winner(scores)
  break unless play_again?
end
display_outro
