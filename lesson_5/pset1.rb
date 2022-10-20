arr = ['10', '11', '9', '7', '8']

arr.sort do |a, b|
  b.to_i <=> a.to_i
end

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

books.sort_by! do |book|
  book[:published]
end

p books

arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
p arr1[-1][-1][-1]

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
p arr2[1][:third][0]

arr3 = [['abc'], ['def'], {third: ['ghi']}]
p arr3[2][:third][0][0]

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
p hsh1['b'][-1]

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
p hsh2[:third].key(0)

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

total = 0

munsters.each_value do |value|
  if value["gender"] == "male"
    total += value["age"]
  end
end

p total

munsters.each do |person, details|
  puts "#{person} is a #{details["age"]}-year-old #{details["gender"]}."
end

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each do |key, val|
  val.each do |word|
    word.each_char {|char| puts char if /[aeiou]/.match(char) }
  end
end

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

new_arr = arr. map do |sub_arr|
  sub_arr.sort {|a, b| b <=> a}
end

p new_arr

arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

new_arr = arr. map do |sub_arr|
  sub_arr.select {|num| num % 3 == 0}
end

p new_arr


arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
hash = {}

arr. each do |sub_arr|
  hash[sub_arr[0]] = sub_arr[1]
end

p hash

arr = [[1, 6, 9], [6, 1, 7], [1, 8, 3], [1, 5, 9]]
arr.sort_by! do |sub_arr|
  filter  = sub_arr.select do |num|
    num.odd?
  end
end
p arr

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}


hsh = hsh.map do |_, val|
  if val[:type] == 'fruit'
    val[:colors].map do |color|
      color[0] = color[0].upcase
      color
    end
  else
    val[:size].upcase
  end
end

p hsh

arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]
