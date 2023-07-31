module Enumerable
  # Your code goes here
  def my_each_with_index
    return self.to_enum(:each_with_index) unless block_given?
    array_length = self.length - 1
    for element in (0..array_length)
      yield(self[element], element)
    end
    return self
  end 

  
  def my_select
    return self.to_enum(:select) unless block_given?
    matched_values = []
    self.my_each do |value|
      if yield(value)
        matched_values << value
      end
    end
    return matched_values
  end
  
  def my_all?
    matched_values = self.my_select do |value|
      yield(value)
    end
    matched_values == self 
  end

  def my_any?(&block)
    matched_numbers = []
    return "No block given" unless block_given?
    self.my_each do |number|
      if block.call(number)
        matched_numbers << number
      end
    end
    matched_numbers.length >= 1
  end

  def my_none?
    self.my_select { |value| yield(value) }.length >= 1 ? false : true
  end

  def my_count
    return self.size unless block_given?
    count = 0
    self.each do |value|
      if yield(value)
        count += 1
      end
    end
    count
  end

  def my_inject(initial_value=nil)
    accumulator = initial_value
    if accumulator.nil?
      accumulator = self.first
      for i in (0..self.size - 2)
        accumulator = yield(accumulator, self[i + 1])
      end
    else 
      for i in (0..self.size - 1)
        accumulator = yield(accumulator, self[i])
      end
    end
    accumulator
  end

  def my_map
    new_array = []
    if block_given? 
      self.my_each do |value|
        new_array << yield(value)
      end
    else
      return self.to_enum(:map)
    end
    new_array
  end

end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return self.to_enum unless block_given?
    array_length = self.length - 1
    for element in (0..array_length)
      yield(self[element])
    end
    return self
  end
end
