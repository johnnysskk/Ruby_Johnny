class School
  attr_accessor :student_hash
  def initialize
    @student_hash = Hash.new
  end

  def add(name, grade)
    temp_array = grade(grade)
    temp_array << name.to_s
    student_hash[grade] = temp_array
  end

  def grade(grade)
    student_list = student_hash[grade]
    return student_list if student_list
    return []
  end

  def to_h
    sorted_hash = {}
    student_hash.each do |key,value|
      sorted_hash[key] = student_hash[key].sort
    end
    Hash[sorted_hash.sort]
  end
end