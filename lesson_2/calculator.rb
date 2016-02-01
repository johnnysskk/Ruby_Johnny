#ask for two numbers from users
#ask the user for an operation to perform
#perfom the operation
#output the result



def prompt(message)
  puts "=> #{message}"
end

def is_valid(number)
  if number != 0
    true
  else
    false
  end
end

def action_word(op)
  case op
  when '1'
    return "Adding"
  when '2'
    return 'Substracting'
  when '3'
    return 'Dividing'
  when '4'
    return 'Multiplying'
  end
end

prompt("Welcome to calculator!!")



loop {
first_number = 0
second_number = 0

loop {
prompt("Please give me the first nubmer: ")
first_number = gets.chomp().to_f
if is_valid(first_number)
  break
else
  prompt("Looks like you inputs something wrong!!, try again!!")
end
}


loop {
prompt("Please give me the second number: ")
second_number = gets.chomp().to_f
if is_valid(second_number)
  break
else
  prompt("Looks like you inputs something wrong!!, try again!!")
end
}


operation = ''

string_block = <<-BLOCK
What operation do you want to perform? 
  1) add    
  2) substract  
  3) divide  
  4) multiply
BLOCK

loop do
prompt(string_block)
operation = gets.chomp()
options = ['1', '2', '3', '4']
#or use %w(1 2 3 4 ).include?(operation)
if options.include?(operation)
  break
else
  prompt("Please enter a valid operation!!!")
end
end

prompt("#{action_word(operation)} two numbers.......")

case operation
when "1" 
  prompt("The result is: #{first_number + second_number}")
when "2"
  prompt("The result is: #{first_number - second_number}")
when "3"
  prompt("The result is: #{first_number / second_number}")
when "4"
  prompt("The result is: #{first_number * second_number}")
else
  prompt("Please give me a valid input!!")
end

prompt ("Do you want to do another operation? y or n")
answer = gets.chomp()
if answer.downcase.start_with?('y')
  next
else
  prompt("Thanks for using calculator!!!!")
  break
end
}





