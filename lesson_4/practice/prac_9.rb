words = "the flintstones rock"

words = words.split

words.each { |word| word.capitalize! }

words = words.join(' ')

puts words
