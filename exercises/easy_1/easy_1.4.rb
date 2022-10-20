vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

def count_occurrences(vehicles)
  tally = {}
  types = vehicles.uniq
  types.each do |word|
    tally[word] = vehicles.count(word)
  end
  tally.each { |k, v| puts "#{k} => #{v}" }
end
puts`clear`
count_occurrences(vehicles)

  