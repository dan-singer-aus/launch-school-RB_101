# Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

tally = {}

statement.each_char do |char|
  if tally[char]
    tally[char] += 1
  else
    tally[char] = 1
  end
end

p tally

