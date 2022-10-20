def stringy(number)
  counter = 1
  string_output = ''
  number.times do
    if counter % 2 == 1
      string_output += '1'
    else
      string_output += '0'
    end
    counter += 1
  end
  string_output
end

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'