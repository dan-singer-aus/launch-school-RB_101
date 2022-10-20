*** QUESTION 1 ***
Every object in Ruby has access to a method called object_id, which returns a numerical value that uniquely identifies the object. This method can be used to determine whether two variables are pointing to the same object.

Take a look at the following code and predict the output:

    a = "forty two"
    b = "forty two"
    c = a

    puts a.object_id
    puts b.object_id
    puts c.object_id

ANSWER:
    101
    102
    101
    a and c will have the same object ID as they are pointing to the same place in memory

*** QUESTION 2 ***
Let's take a look at another example with a small difference in the code:

    a = 42
    b = 42
    c = a

    puts a.object_id
    puts b.object_id
    puts c.object_id

ANSWER:
    101
    101
    101
    They all have the same object ID because intergers are immutable and not stored over and over

*** QUESTION 3 ***
Let's call a method, and pass both a string and an array as arguments and see how even though they are treated in the same way by Ruby, the results can be different.

Study the following code and state what will be displayed...and why:

    def tricky_method(a_string_param, an_array_param)
      a_string_param += "rutabaga"
      an_array_param << "rutabaga"
    end

    my_string = "pumpkins"
    my_array = ["pumpkins"]
    tricky_method(my_string, my_array)

    puts "My string looks like this now: #{my_string}"
    puts "My array looks like this now: #{my_array}"
    
ANSWER:
    My string looks like this now: pumpkins
    My array looks like this now: ["pumpkins", "rutabaga"]
    The += operator is reassigning the variable whereas << append the new object to the original array object



*** QUESTION 4 ***
To drive that last one home...let's turn the tables and have the string show a modified output, while the array thwarts the method's efforts to modify the caller's version of it.

    def tricky_method_two(a_string_param, an_array_param)
      a_string_param << 'rutabaga'
      an_array_param = ['pumpkins', 'rutabaga']
    end

    my_string = "pumpkins"
    my_array = ["pumpkins"]
    tricky_method_two(my_string, my_array)

    puts "My string looks like this now: #{my_string}"
    puts "My array looks like this now: #{my_array}"

ANSWER: 
    My string looks like this now: pumpkinsrutabaga
    My array looks like this now: ["pumpkins"]
    This is different because the =+ operators in returning a new object within the loacl scope of the method. Again, << will apppend to the original object

*** QUESTION 5 ***
Depending on a method to modify its arguments can be tricky:

    def tricky_method(a_string_param, an_array_param)
      a_string_param += "rutabaga"
      an_array_param << "rutabaga"
    end

    my_string = "pumpkins"
    my_array = ["pumpkins"]
    tricky_method(my_string, my_array)

    puts "My string looks like this now: #{my_string}"
    puts "My array looks like this now: #{my_array}"

Whether the above "coincidentally" does what we think we wanted depends upon what is going on inside the method.

How can we change this code to make the result easier to predict and easier for the next programmer to maintain? That is, the resulting method should not mutate either argument, but my_string should be set to 'pumpkinsrutabaga' and my_array should be set to ['pumpkins', 'rutabaga']

ANSWER:
    def not_so_tricky_method(a_string_param, an_array_param)
      a_string_param += "rutabaga"
      an_array_param += ["rutabaga"]
      return a_string_param, an_array_param
    end

    my_string = "pumpkins"
    my_array = ["pumpkins"]
    my_string, my_array = not_so_tricky_method(my_string, my_array)

    puts "My string looks like this now: #{my_string}"
    puts "My array looks like this now: #{my_array}"

    a method can return more than one value.

*** QUESTION 6 ***
How could the following method be simplified without changing its return value?

    def color_valid(color)
      if color == "blue" || color == "green"
        true
      else
        false
      end
    end

ANSWER:
    def color_valid(color)
      color == "blue" || color == "green" ? true : false
    end

LS ANSWER:
    def color_valid(color)
      color == "blue" || color == "green"
    end

