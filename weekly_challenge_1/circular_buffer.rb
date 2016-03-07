require 'pry'

class BufferEmptyException < StandardError; end
class BufferFullException < StandardError; end

class CircularBuffer
  attr_accessor :read_pointer, :write_pointer, :items, :buffer_hash, :width
  
  def initialize(index)
    @read_pointer = 0
    @write_pointer = 0
    @width = index
    @items = 0    
    @buffer_hash = Hash.new
    (1..index.to_i).each do |index| 
      buffer_hash[index] = nil
    end
    #binding.pry
  end

  def update_pointer(pointer)
    pointer = pointer.to_i
    if pointer == width - 1 
      pointer  = 0
    else
      pointer += 1
    end
    pointer
  end

  def write(content)
    #binding.pry
    if items == width
      raise CircularBuffer::BufferFullException
    end
    self.buffer_hash[write_pointer] = content.to_s unless content == nil
    self.write_pointer = update_pointer(write_pointer) unless content == nil
    #binding.pry
    self.items = items + 1 unless content == nil
  end

  def write!(content)
    if items == width
    self.read_pointer = update_pointer(write_pointer) unless content == nil
    self.buffer_hash[write_pointer] = content.to_s unless content == nil
    self.write_pointer = update_pointer(write_pointer) unless content == nil
    #binding.pry
    else
    self.buffer_hash[write_pointer] = content.to_s unless content == nil
    self.write_pointer = update_pointer(write_pointer) unless content == nil
    self.items = items + 1 unless content == nil
    end
  end

  def clear
    buffer_hash.each do |x,y|
      buffer_hash[x] = nil
      self.items = 0
    end
  end


  def read
    if items == 0
      raise CircularBuffer::BufferEmptyException
    end
    data = buffer_hash[read_pointer]
    buffer_hash[read_pointer] = nil
    self.read_pointer = update_pointer(read_pointer)
    self.items -= 1
    data
  end

end
