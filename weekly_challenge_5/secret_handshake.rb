require 'pry'

class SecretHandshake
   attr_accessor :string
   TABLE = {
       '1' => 'wink',
       '10' => 'double blink',
       '100' => 'close your eyes', 
       '1000' => 'jump'
   }
   def initialize(number)
       number = 0  if number.is_a? String
       number_string = number.to_s(2)
       @string = number_string
   end
   
   def put_value_in
           new_array = []
           number_array = string.split('')
           length = number_array.size
           
           new_array << TABLE['1'] if number_array.last == '1'
           new_array << TABLE['10'] if number_array[length-2] == '1' && length -2 >= 0 
           new_array << TABLE['100'] if number_array[length-3] == '1' && length -3 >= 0
           new_array << TABLE['1000'] if number_array[length -4] == '1' && length -4 >= 0
           #binding.pry
           new_array
   end
   
   
   def commands
       new_array = []
       length = string.length
       if length < 5
          new_array = put_value_in
       else
          if string[length-5] == '1'
            new_array = put_value_in.reverse
          end
       end
       new_array
   end
end


obj = SecretHandshake.new(2)
obj.commands
