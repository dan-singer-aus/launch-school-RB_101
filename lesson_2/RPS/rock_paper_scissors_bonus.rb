require 'yaml'
MSG = YAML.load_file('RPS_Bonus.yml')

# 'beats' hash contains a given moves win conditions
MOVES = {
  "r" => { name: "Rock", beats: ["l", "sc"] },
  "p" => { name: "Paper", beats: ["r", "sp"] },
  "sc" => { name: "Scissors", beats: ["p", "l"] },
  "l" => { name: "Lizard", beats: ["p", "sp"] },
  "sp" => { name: "Spock", beats: ["r", "sc"] }
}

# move_name and move_beats are both shorthand methods
#  for accessing hashes nested in MOVES
def move_name(move)
  MOVES[move][:name]
end

def move_beats(move)
  MOVES[move][:beats]
end

# Shorthand method for Kernel.puts()
def prompt(message)
  Kernel.puts(message)
end

# Handles the timing of the intro sequence
def welcome
  prompt(`clear`)
  sleep(0.5)
  prompt(MSG["welcome"])
  time = 0.05
  MSG["instructions"].each do |line|
    line.each_char do |char|
      print char
      sleep(time)
      time *= 0.99
    end
    Kernel.puts()
  end
  sleep(0.5)
  prompt(`clear`)
end

# Formats and displays the header for each round
def round_prompt(counter, points)
  prompt(`clear`)
  header = MSG["round"].join("\n")
  header = format(header, count: counter, player: points[0], comp: points[1])
  prompt(header)
  sleep(0.5)
end

# Prompts user for a move and returns respective key from MOVES
def get_move
  selection = ''
  loop do
    prompt(MSG["select"])
    MOVES.each_key do |key|
      Kernel.puts("Type '#{key}' for #{move_name(key)}")
    end
    selection = Kernel.gets().chomp().downcase()
    if MOVES.keys.include?(selection)
      break
    else
      prompt("Invalid input")
    end
  end
  selection
end

# Handles display timing and format of move choices
def display_choices(player, computer)
  sleep(0.5)
  prompt(`clear`)
  print("You chose #{move_name(player)}")
  sleep(0.75)
  puts("   Computer chose #{move_name(computer)}")
  puts
end

# Checks if either players move is in the others win condition
#  returns who won the round
def find_winner(player, computer)
  if move_beats(player).include?(computer)
    "Player"
  elsif move_beats(computer).include?(player)
    "Computer"
  else
    "Tie"
  end
end

# Handles timing of how each winner is diplayed
def display_winner(winner)
  sleep(0.5)
  case winner
  when "Player"
    prompt(MSG["win_p"])
  when "Computer"
    prompt(MSG["win_c"])
  when "Tie"
    prompt("Tie")
  end
  sleep(1)
end

def update_score(score_arr, winner)
  case winner
  when "Player"
    score_arr[0] += 1
  when "Computer"
    score_arr[1] += 1
  end
  
  score_arr
end

# Handles timing and duration of flasing messages
#  Takes and Array of strings
def flash(messages)
  3.times do
    prompt(`clear`)
    sleep(0.075)
    messages.each { |line| prompt(line) }
    sleep(0.3)
  end
end

# Checks if a player has enough points to win.
#   Displays the winner and returns true
def display_champ(score)
  if score[0] == 3
    flash(MSG["you_won"])
    sleep(1.2)
    true
  elsif score[1] == 3
    flash(MSG["you_lose"])
    sleep(1.2)
    true
  end
end

# Handles timing exit program message sequence
def display_close
  prompt(`clear`)
  prompt(MSG["end"])
  sleep(2)
  prompt(`clear`)
end

# Main program
loop do
  welcome
  # score[0] is the player score[1] is computer
  score = [0, 0]
  round_count = 1

  loop do
    round_prompt(round_count, score)
    choice = get_move
    computer_choice = MOVES.keys.sample
    display_choices(choice, computer_choice)
    winner = find_winner(choice, computer_choice)
    display_winner(winner)
    score = update_score(score, winner)
    break if display_champ(score)
    round_count += 1
  end

  prompt(`clear`)
  prompt(MSG["replay"])
  replay = Kernel.gets().chomp
  break unless replay.downcase.start_with?('y')
end

display_close
