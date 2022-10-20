def reverse_sentence(sentence)
  word_array = sentence.split(' ')
  word_array.reverse!
  word_array.join(' ')
end

puts reverse_sentence('Hello World') == 'World Hello'
puts reverse_sentence('Reverse these words') == 'words these Reverse'
puts reverse_sentence('') == ''
puts reverse_sentence('    ') == '' 
