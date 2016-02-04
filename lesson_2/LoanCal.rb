
def prompt(message)
  puts "=>#{message}"
end

def isInteger?(number)
 return number.to_i.to_s == number  
end

def isFloat?(number)
  return number.to_f.to_s == number
end

loop do 

loan = 0
apr = 0
duration = 0
loop do
prompt("How much loan do you want to get ? ")
loan = gets.chomp
if isInteger?(loan)
  break
else
  puts "Please input valid value!!"
end
end

loop do
prompt("What is the APR ? ex. 3 for 3%, 3.5 for 3.5%")
apr = gets.chomp
if isFloat?(apr) || isInteger?(apr)
  break
else
  puts "Please input valid value!!"
end
end

loop do
prompt('What is the loan duration? (in year)')
duration = gets.chomp
if isInteger?(duration)
  break
else
  puts "Please input valid value!!"
end
end

duration_m = duration * 12
interest_rate = apr.to_f / 100
monthly_rate = interest_rate / 12
monthly_payment = loan.to_f * (monthly_rate / (1-(1+monthly_rate)** - duration_m.to_i))

prompt("The monthly payment is: #{format('%02.2f',monthly_payment)}")

prompt("Calculate another one?")
result = gets.chomp

break unless result.downcase.start_with?('y')

end

prompt("Good bye!!!")

