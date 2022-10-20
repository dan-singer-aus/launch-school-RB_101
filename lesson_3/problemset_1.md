*** QUESTION 1 ***
What would you expect the code below to print out?

  numbers = [1, 2, 2, 3]
  numbers.uniq

  puts numbers

ANSWER:
#uniq does not mutat the caller so the print out would be:
1
2
2
3

*** QUESTION 2 ***
Describe the difference between ! and ? in Ruby. And explain what would happen in the following scenarios:

what is != and where should you use it?
ANSWER: 'Not equals' operator, used in if conditions

put ! before something, like !user_name
ANSWER: Converts an object to the boolean opposite. Something that is truthy will be conferted to false

put ! after something, like words.uniq!
ANSWER: Generally used to indicate that a method mutates a caller but not a rule.

put ? before something
ANSWER: Ternary operator, the object following the ? will be returned if true, and the object after : if false.

put ? after something
ANSWER: Generally used to indicate a methods return value is a boolean but not a rule 

put !! before something, like !!user_name
ANSWER: Converts an object to the boolean equivalent. Something truthy will return true

*** QUESTION 3 ***
Replace the word "important" with "urgent" in this string:
  advice = "Few things in life are as important as house training your pet dinosaur."

ANSWER: advice.sub!('important', 'urgent')

*** QUESTION 4 ***
The Ruby Array class has several methods for removing items from the array. Two of them have very similar names. Let's see how they differ:
  numbers = [1, 2, 3, 4, 5]

What do the following method calls do (assume we reset numbers to the original array between method calls)?
  numbers.delete_at(1)
  numbers.delete(1)

ANSWER: numers.delete_at(1) => [1, 3, 4, 5]
        nmubers.delete(1) => [2, 3, 4, 5]

*** QUESTION 5 ***
Programmatically determine if 42 lies between 10 and 100.
ANSWER: (10..100).include?(42)

*** QUESTION 6 ***
Starting with the string:
  famous_words = "seven years ago..."

show two different ways to put the expected "Four score and " in front of it.

ANSWER: famous_words = "Four score and " + famous_words
        famous_words.insert(0, "Four score and ")
More options:
        famous_words.prepend("Four score and ")
        "Four score and " << famous_words

*** QUESTION 7 ***

If we build an array like this:
  flintstones = ["Fred", "Wilma"]
  flintstones << ["Barney", "Betty"]
  flintstones << ["BamBam", "Pebbles"]

We will end up with this "nested" array:
["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]

Make this into an un-nested array.

ANSWER: flintsones.flatten!

*** QUESTION 8 ***
Given the hash below
  flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

Turn this into an array containing only two elements: Barney's name and Barney's number

ANSWER: flintstones = flintstones.assoc("Barney")

