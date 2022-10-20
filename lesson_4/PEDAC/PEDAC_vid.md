## Sum Even Number Rows

# Problem
Imagine a sequence of consecutive even integers begining with the number 2. The integers are grouped in rows, with the first row containing one integer, the second row two itegers, the third row three integers, and so on. Given an integer representing the number of a particular row, return an integer representing the sum of all the integers in that row.

# PEDAC:

# Problem
input: integer
output: integer
rules:
      Exlplicit requirements:
        - sequence of even integers
        - sequence begins with two
        - integers are consecutive
        - sequence is grouped into rows
        - Each row is incrementally larger: 1, 2, 3, 4, 5
        - Row 'number' equals the number of elements in the row
        - Row number equlas the number of elements in the row
          - Row 1 has 1 element , row 2 has 2 elements....
        - input identifies a 'row'. which is a subset of the sequence
        - output is the sum of the integers in the row identified by the input integer

      Implicit requirements:
        -
        -
        -

# Examples

row number: 1 --> sum of integers in row: 2
row number: 2 --> sum of integers in row: 10
row number: 4 --> sum of integers in row: 68

# Data Structures
Overall structure representing sequence as a whole
Individual rows within overall structure 
Individual rows in a set order in context of sequence
Individual rows contain integers
Can assume that integers are in a set order in the context of the sequence

# Algoritms
1. Create an empty 'rows' array to contain all of the rows
2. Create a 'row' array and add it to the overall 'rows' array 
3. Repreat step 2 until all the necessary rows have been created
4. Sum the final row
5. Return the sum

*Problem: create a row*

Rules:
  - Row is an array
  - Arrays contain integers
  - Integers are consecutive even numbers
  - Integers are consecutive even numbers
  - Integers in each row form part of an overall larger sequence
  - Rows are of different lengths 
Input: the information neede to create the output
   - The starting integer
   - Length of the row
Output: the row itself

Examples:
start: 2, length: 1 --> [2]
start: 4, length: 2 --> [4, 6]
start: 8, length: 3 --> [8, 10, 12]

Data structures:
- an array of integers

Algorithm:
1. Create an empty row to contain the integers
2. add the starting integer
3. Increment the starting integer by 2 to get the next integer in the sequence
  - all rows have been created when the length of the 'rows' is equal to the input
4. Repeate steps 2 & 3 until the array has reached the correct length
5. Return the 'row' array


# Final Thoughts
- Not a completely linear process
- Move back and forth between the steps
- Switch from implementation mode to abstract problem solving mode when necessary
- Don't try to problem solve at the code level  