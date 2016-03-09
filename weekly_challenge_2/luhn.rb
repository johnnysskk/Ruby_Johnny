class Luhn
  attr_accessor :number_list , :width
  def initialize(number)
    @number_list = number.to_s.split(//).select do |num|
        num.to_i.is_a? Integer 
    end
    @number_list = @number_list.map do |num|
      num.to_i
    end
    @width = number_list.size
      
  end

  def correct_number(number)
    if number * 2 >= 10 
      number = number * 2 - 9
    else
      number = number * 2
    end
    number
  end

  def addends
      location = 0
      new_list = []
      number_list.reverse.each do |num|
        if location.odd? 
          new_list[width - location -1 ]  = correct_number(num)
        else
          new_list[width - location -1 ] = num
        end
        location += 1
      end
      new_list
  end

  def addends_2(number_list)
      location = 0
      new_list = []
      number_list.reverse.each do |num|
        if location.odd? 
          new_list[width - location -1 ]  = correct_number(num)
        else
          new_list[width - location -1 ] = num
        end
        location += 1
      end
      new_list
  end

  def checksum
    sum = 0
    addends.each do |num|
      sum += num
    end
    sum
  end

  def checksum_2(list)
    sum = 0
    addends_2(list).each do |num|
      sum += num
    end
    sum
  end



  def valid?
    return checksum % 10 == 0 
  end

  def self.create(number)
    # number_list = number.to_s.split(//).select do |num|
    #     num.to_i.is_a? Integer 
    # end
    # number_list = number_list.map do |num|
    #   num.to_i
    # end
    obj = Luhn.new(number)
    if !obj.valid?
      new_list = obj.number_list << 0
      size = new_list.size
      sum = obj.checksum_2(new_list)
      if sum % 10 != 0
        add_number = 10 - sum % 10
      else
        add_number = 0
      end
      new_list[size-1] = add_number
      return new_list.join.to_i
    else
      return obj.number_list.join.to_i
    end
  end

end


test = Luhn.new(1234)
#puts test.number_list
#rint test.addends
