MOVES = ["rock", "paper", "scissors"]

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  (first == "rock" && second == "scissors") ||
    (first == "paper" && second == "rock") ||
    (first == "scissors" && second == "paper")
end

def  display_winner(player, computer)
  if win?(player, computer)
    prompt("Player wins")
  elsif win?(computer, player)
    prompt("Computer wins")
  else
    prompt("Tie")
  end
end

prompt("Welcome to Rock Paper Scissors")

loop do
  selection = ''
  loop do
    prompt("Select your move: #{MOVES.join(', ')}")
    selection = Kernel.gets().chomp().downcase()
    if MOVES.include?(selection)
      break
    else
      prompt("Invalid input")
    end
  end

  computer_selection = MOVES.sample

  prompt("player selects: #{selection} computer selects: #{computer_selection}")

  display_winner(selection, computer_selection)

  prompt("would you like to play again? (Y/N)")
  answer = Kernel.gets().chomp().downcase()
  break unless answer.start_with?("y")
end

prompt("Goodbye")
