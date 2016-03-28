class Atbash
  #build the table char part
  @@MAP_TABLE = {}
  small_char_array = ('a'..'z').to_a.reverse
  ('a'..'z').each_with_index do |char,index|
    @@MAP_TABLE[char] = small_char_array[index]
    @@MAP_TABLE[char.upcase] = small_char_array[index]
  end
  #build the table number part 
  (0..9).each do |num|
    @@MAP_TABLE[num.to_s] = num.to_s
  end

  def self.encode(string)
    string_array = string.delete(' ,.').split("")
    new_array = []
    string_array.each do |x|
      new_array << @@MAP_TABLE[x]
    end
    new_array.join
             .scan(/.....|.+/)
             .join(' ')
  end
  
end