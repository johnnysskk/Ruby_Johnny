require 'pry'
class School
  attr_accessor :student_hash
  def initialize
    @student_hash = {}
  end

  def add(name, grade)
    student_hash[grade] = []
    student_hash[grade] << name.to_s
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
    return sorted_hash
  end
end

school = School.new
binding.pry
puts school.to_h.to_s