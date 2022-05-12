Consider the following method and a call to that method:

def my_method(a, b = 2, c = 3, d)
  p [a, b, c, d]
end

my_method(4, 5, 6)
Use the ruby documentation to determine what this code will print.

*** ANSWER: ***
This is a syntax question so first check syntax and it gives you two choices:
-> Methods
   Method and method argument syntax
-> Calling Methods
   How to call a method (or send a message to a method)

This question is about calling methods so check there

Under Default Positional Arguments it says:
"Ruby will fill in the missing arguments in-order"
"Ruby fills in the missing arguments from left to right."

So therefore my_method(4, 5, 6) will return:
=> [4, 5, 3, 6] 


