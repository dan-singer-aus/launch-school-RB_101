# PROBLEM:

Given a string, write a method `palindrome_substrings` which returns
all the substrings from a given string which are palindromes.
*palindrome words case sensitive.*

# Test cases:
palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
palindrome_substrings("palindrome") == []
palindrome_substrings("") == []

# Questions


*** Problem Articulation ***
input: string
output: array
rules:
      Exlplicit requirements:
        - every palindrome in the string must be added to an array
        - a palindrome is a word that reads the same forwards and backward
        - palindromes are case sensitive
        - method must be called "palindrome_substrings"
      Implicit requirements:
        - an array of all palindomes must be returned
        - if the string contains no palindromes, return an empty array
        - if the input string is empty, return an empty array
 
*** Algorithm ***
substrings method
=================
    - create an empty array called `result` that will contain all required substrings
    - create a `starting_index` variable (value `0`) for the starting index of a substring
    - start a loop that iterates over `starting_index` from `0` to the length of the string minus 2
      - create a `num_chars` variable (value `2`) for the length of a substring
      - start an inner loop that iterates over `num_chars` from `2` to `string.length - starting_index`
        - extract a substring of length `num_chars` from `string` starting at `starting_index`
        - append the extracted substring to the `result` array
        - increment the `num_chars` variable by `1`
      - end the inner loop
      - increment the `starting_index` variable by `1`
    - end the outer loop
    - return the `result` array

is_palindrome? method
=====================
 - Inside the `is_palindrome?` method, check whether the string
   value is equal to its reversed value. You can use the
   String#reverse method.

palindrome_substrings method
============================
  - initialize a result variable to an empty array
  - create an array named substring_arr that contains all of the
    substrings of the input string that are at least 2 characters long.
  - loop through the words in the substring_arr array.
  - if the word is a palindrome, append it to the result
    array
  - return the result array
