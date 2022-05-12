require 'yaml'
MESSAGES = YAML.load_file('mort_calc_messages.yml')

# I initialized the global vraibles fist as I knew I would need these
prinicipal = ''
interest = ''
loan_years = ''
loan_months = ''

# Check if the number is a valid int or float by passing in the input and
#   whether to check int or float
def valid_number?(num, type)
  case type
  when "float"
    Float(num, exception: false)
  when "int"
    Integer(num, exception: false) && num.to_i >= 0
  end
end

# Because I decided use a message file with function retreives the message
#   from the yml dictionary/hash puts it
def prompt(key)
  message = MESSAGES[key]
  Kernel.puts("=> #{message}")
end

prompt("welcome")

# This loop wraps the loan calcultor so that the user
#   can run the calculator repeatedly
loop do
  # Get the principle ammount of the loan but if user input is
  #   invalid request again
  loop do
    prompt("get_prinicpal")
    print "$"
    prinicipal = Kernel.gets().chomp()
    break if valid_number?(prinicipal, "float")
    prompt("invalid")
  end

  # Save the Prinicle as a float
  principal = prinicipal.to_f

  # Get the interest rate of the loan but if user input is invalid request again
  loop do
    puts "Enter the annual interest rate below:"
    interest = Kernel.gets().chomp()
    break if valid_number?(interest, "float")
    prompt("invalid")
  end

  # Convert the interest rate to a monthly rate and
  #   set it in the correct mathamatical format
  interest_month = (interest.to_f / 12) / 100

  # Get the year duration of the loan but if user input is invalid request again
  loop do
    puts "Enter the total number of years the loan is"
    loan_years = Kernel.gets().chomp()
    break if valid_number?(loan_years, "int")
    prompt("invalid")
  end

  # Incase the loan is 1 year and 4 months I gave the user the ability to add
  #   months. user cannot add more that 12 months.
  loop do
    puts "Enter the total number of months the loan is"
    loan_months = Kernel.gets().chomp()
    break if valid_number?(loan_months, "int") && loan_months.to_i < 12
    prompt("invalid")
  end

  # Convert the years to moths and add the month input to get the total
  #   in months
  loan_time = loan_months.to_i + (loan_years.to_i * 12)

  # Run the loan payment calculator and output the answer
  monthly_payments = principal * (interest_month /
                     (1 - (1 + interest_month)**(-loan_time)))
  puts "=> Your monthly repayment will be $#{monthly_payments.round(2)}"

  # Request if the user would like to do another equation
  #   and if not exit the program
  puts "=> Would you like to run another calculataion?"
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end
puts "Thanks"
