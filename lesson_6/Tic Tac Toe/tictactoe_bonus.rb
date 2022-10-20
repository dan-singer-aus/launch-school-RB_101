require 'yaml'

SCRN = YAML.load_file('TTT.yml')
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

def alternate_turn(current_turn)
  case current_turn
  when "player" then "computer"
  when "computer" then "player"
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def champ?(score, mode)
  case mode
  when 'easy'
    score.value?(3)
  when 'medium'
    score.value?(5)
  when 'hard'
    score.value?(1)
  end
end

def champ_animation
  25.times do
    render_scrn("champ1")
    sleep(0.05)
    render_scrn("champ2")
    sleep(0.05)
  end
end

def choose_starter
  loop do
    render_scrn("starter")
    prompt "Choose who starts each round:"

    choice = gets.chomp.downcase

    if ["player", "p"].include?(choice)
      break "player"
    elsif ["computer", "c"].include?(choice)
      break "computer"
    elsif ["random", "r"].include?(choice)
      break "random"
    else
      display_error
    end
  end
end

def coin_flip
  options = ["player", "computer"]
  starter = ''
  30.times do
    starter = options.sample
    render_scrn(starter)
    sleep(0.05)
  end

  starter
end

def cpu_choice(brd, mode)
  case mode
  when 'easy'
    empty_squares(brd).sample
  when 'medium'
    cpu_strategy_medium(empty_squares(brd), brd)
  when 'hard'
    cpu_strategy_hard(brd)
  end
end

def cpu_strategy_hard(brd)
  best_value = -1000
  best_move = 0

  empty_squares(brd).each do |square|
    brd[square] = COMPUTER_MARKER
    value = minimax(brd, false)
    brd[square] = ' '
    if value > best_value
      best_move = square
      best_value = value
    end
  end
  best_move
end

def cpu_strategy_medium(options, brd)
  offense = play_offensive(options, brd)
  defense = play_defensive(options, brd)

  if !offense.empty?
    offense.sample
  elsif !defense.empty?
    defense.sample
  elsif options.include?(5)
    5
  else
    options.sample
  end
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if line.all? { |idx| brd[idx] == PLAYER_MARKER }
      return "player"
    elsif line.all? { |idx| brd[idx] == COMPUTER_MARKER }
      return "computer"
    end
  end
  nil
end

def display_board(brd, score, mode)
  display_scoreboard(score, mode)
  board = SCRN["board"].join("\n")
  puts format(board, sq1: brd[1],
                     sq2: brd[2],
                     sq3: brd[3],
                     sq4: brd[4],
                     sq5: brd[5],
                     sq6: brd[6],
                     sq7: brd[7],
                     sq8: brd[8],
                     sq9: brd[9])
end

def display_champ(score)
  champ = score.max_by { |_, value| value }[0].to_s
  if champ == "player"
    champ_animation
  else
    render_scrn("game_over")
    sleep(3)
  end
end

def display_error
  render_scrn("error")
  sleep(1.5)
end

def display_first_mover(starter)
  puts `clear`
  if starter == "player"
    starter = "  " + starter
  end
  screen = SCRN["first_move"].join("\n")
  puts format(screen, starter: starter.upcase)
end

def display_game_intro
  render_scrn("welcome1")
  sleep(0.5)
  render_scrn("welcome2")
  sleep(0.75)
end

def display_game_outro
  render_scrn("end_1")
  sleep(0.5)
  render_scrn("welcome2")
  sleep(0.75)
  puts `clear`
end

def display_result(result)
  case result
  when 'player' then render_scrn('round_winner_p')
  when 'computer' then render_scrn('round_winner_c')
  when 'tie' then render_scrn('round_winner_t')
  end
  sleep(2)
end

def display_scoreboard(score, mode)
  puts `clear`
  mode += "  " if ["easy", "hard"].include?(mode)
  scoreboard = SCRN["scoreboard"].join("\n")
  puts format(scoreboard, mode: mode.capitalize,
                          p_score: score[:player],
                          c_score: score[:computer])
end

def display_selection(current_player, piece)
  puts "#{current_player.capitalize} chose #{piece}".center(56)
  sleep(1)
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == ' ' }
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = ' ' }
  new_board
end

def initialize_game
  mode = select_mode
  starter = make_starter(mode)
  scores = { "player": 0, "computer": 0 }
  return mode, starter, scores
end

def joinor(list, delimeter=', ', endjoin='or')
  string_list = ''
  iterations = list.size - 1

  if iterations > 0
    iterations.times do |idx|
      string_list << list[idx].to_s
      string_list << delimeter unless idx == list.size - 2
    end
    string_list << " #{endjoin} "
  end
  string_list << list.last.to_s
end

def make_starter(mode)
  if mode == "easy"
    "player"
  elsif mode == "medium"
    choose_starter
  elsif mode == "hard"
    "random"
  end
end

def place_piece!(current_player, brd, piece)
  brd[piece] = if current_player == "player"
                 PLAYER_MARKER
               else
                 COMPUTER_MARKER
               end
end

def play_again?
  puts `clear`
  puts SCRN["play_again"]
  prompt "Enter choice:"
  answer = gets.chomp.downcase
  if answer == 'y' || answer == 'yes'
    true
  end
end

def play_defensive(options, brd)
  options.select do |space|
    available_sets = WINNING_LINES.select { |line| line.include?(space) }
    available_sets.any? do |line|
      brd.values_at(*line).count(PLAYER_MARKER) == 2
    end
  end
end

def play_offensive(options, brd)
  options.select do |space|
    available_sets = WINNING_LINES.select { |line| line.include?(space) }
    available_sets.any? do |line|
      brd.values_at(*line).count(COMPUTER_MARKER) == 2
    end
  end
end

def player_choice(brd)
  choice = ''

  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    choice = gets.chomp.to_i
    break if empty_squares(brd).include?(choice)
    puts "Sorry, that is not a valid selection".center(56)
    puts
  end

  choice
end

def prompt(str)
  puts str.center(56)
  print " " * 23 + "=> "
end

def render_scrn(screen)
  puts `clear`
  SCRN[screen].each { |text| puts text }
end

def round_intro(round_count, score)
  puts `clear`
  screen = SCRN["round_intro"].join("\n")
  screen = format(screen, count: round_count,
                          p_score: score[:player],
                          c_score: score[:computer])
  puts screen
  sleep(1)
end

def round_sequence(starter, mode, score)
  starter = coin_flip if starter == "random"
  display_first_mover(starter)
  sleep(1)
  brd = initialize_board
  tictactoe_sequence(brd, score, mode, starter)
  sleep(1)

  if someone_won?(brd)
    detect_winner(brd)
  else
    "tie"
  end
end

def select_mode
  loop do
    render_scrn("menu")
    prompt("Select mode:")
    mode = gets.chomp.downcase
    break "easy" if ["easy", "e"].include?(mode)
    break "medium" if ["medium", "m"].include?(mode)
    break "hard" if ["hard", "h"].include?(mode)
    display_error
  end
end

def select_piece(current_player, brd, mode)
  if current_player == "player"
    player_choice(brd)
  else
    cpu_choice(brd, mode)
  end
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def tictactoe_sequence(brd, score, mode, current_player)
  loop do
    display_board(brd, score, mode)
    piece = select_piece(current_player, brd, mode)
    place_piece!(current_player, brd, piece)
    display_board(brd, score, mode)
    display_selection(current_player, piece)
    break if someone_won?(brd) || board_full?(brd)
    current_player = alternate_turn(current_player)
  end
end

def update_score!(winner, score)
  score[winner.to_sym] += 1 unless winner == "tie"
end

def minimax(brd, is_maximizing)
  return mimnimax_terminator(brd) if mimnimax_terminator(brd)

  if is_maximizing
    minimax_max(brd)
  else
    minimax_min(brd)
  end
end

def minimax_max(brd)
  best_value = -1000
  empty_squares(brd).each do |square|
    brd[square] = COMPUTER_MARKER
    value = minimax(brd, false)
    brd[square] = ' '
    best_value = value if value > best_value
  end
  best_value
end

def minimax_min(brd)
  best_value = 1000
  empty_squares(brd).each do |square|
    brd[square] = PLAYER_MARKER
    value = minimax(brd, true)
    brd[square] = ' '
    best_value = value if value < best_value
  end
  best_value
end

def mimnimax_terminator(brd)
  if detect_winner(brd) == 'computer'
    100
  elsif detect_winner(brd) == 'player'
    -100
  elsif board_full?(brd)
    0
  end
end

display_game_intro
loop do
  mode, starter, scores = initialize_game
  round_count = 1
  loop do
    round_intro(round_count, scores)
    result = round_sequence(starter, mode, scores)
    display_result(result)
    update_score!(result, scores)
    break if champ?(scores, mode)
    round_count += 1
  end

  display_champ(scores)

  break unless play_again? == true
end
display_game_outro
