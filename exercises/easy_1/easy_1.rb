# Write a method that takes two arguments, a string and a positive integer, and prints the string as many times as the integer indicates.

def repeat(ammount, words)
  ammount.times {puts words}
end

repeat(5, "hello")

