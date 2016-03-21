
require 'pry'

class Triplet
  attr_accessor :num_array
  def initialize(a,b,c)
     @num_array = [a,b,c]
  end


  def sum
    num_array[0] + num_array[1] + num_array[2]
  end

  def product
    num_array[0] * num_array[1] * num_array[2]
  end

  def pythagorean?
    temp_array = num_array.sort
    biggest_number = temp_array[2]
    middle_number = temp_array[1]
    smallest_number = temp_array[0]
    return true if biggest_number ** 2 - smallest_number ** 2 == middle_number ** 2
    return false
  end

  def self.pythago? (num_array)
    temp_array = num_array.sort
    biggest_number = temp_array[2]
    middle_number = temp_array[1]
    smallest_number = temp_array[0]
    return true if biggest_number ** 2 - smallest_number ** 2 == middle_number ** 2
    return false
  end

  def self.sum(num_array)
    num_array[0] + num_array[1] + num_array[2]
  end

  def self.where(min_factor:0, max_factor:0, sum:0)
    number_array = (min_factor..max_factor).to_a
    combination_array = number_array.combination(3).to_a
    triplet_array = []
    combination_array.each do |set|
        obj = Triplet.new(set[0], set[1], set[2])
        if sum == 0
          triplet_array << obj if self.pythago?(set)
        else
          triplet_array << obj if self.pythago?(set) && self.sum(set) == sum
        end 
    end
     triplet_array
  end

end

#Triplet.where(min_factor:3, max_factor:10, sum: 24)


