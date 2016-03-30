class Series
  attr_accessor :num_string, :num_array
  def initialize(num_string)
      @num_string = num_string
      @num_array = num_string.chars
      @num_array.map! { |x| x.to_i}
  end
  
  def slices(num)
      raise ArgumentError if num > num_string.length
      new_array = []
      num_array.each_with_index do |x, index | 
          if num_string.length - index >= num
              new_array <<  num_array.slice(index..index+num - 1)
          end
      end
      new_array
  end
    
end

