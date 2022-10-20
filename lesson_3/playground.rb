def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false if dot_separated_words.size != 4
  
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break unless is_an_ip_number?(word)
  end
  
  return true
end

def is_an_ip_number?(number)
  (0..250).include?(number.to_i)
end 

puts dot_separated_ip_address?("4.5.5.250")
puts dot_separated_ip_address?("4.5.5.1.1")
puts dot_separated_ip_address?("4.5.5")
