class Anagram
   attr_accessor :input_string
   def initialize(input_string)
       @input_string = input_string
   end
   def match(words_array)
       new_words_array = words_array.map do |word|
           word.downcase
               .chars
               .sort
               .join
               
       end
       sorted_input_string = input_string.downcase
                                         .chars
                                         .sort
                                         .join
      new_array = []
      new_words_array.each_with_index do |word, index|
          if word == sorted_input_string && words_array[index].downcase != input_string.downcase
              new_array << words_array[index]
          end
      end
      new_array.sort
   end
end