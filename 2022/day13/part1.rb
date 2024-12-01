require 'pp'

def parse_signal(signal)
  elements = []
  next_element = ''
  reading_list = false
  signal[1..-2].chars.each_with_index do |char, i|
    if !reading_list
      if char == '['
        reading_list = true
        next_element << char
      elsif char == ','
        elements << next_element.to_i
        next_element = ''
      elsif i == signal.length - 3
        next_element << char
        elements << next_element.to_i
      else
        next_element << char
      end
    else
      if char == ','
        if next_element.scan(/\[/).length == next_element.scan(/\]/).length
          elements << parse_signal(next_element)
          reading_list = false
          next_element = ''
        else
          next_element << char
        end
      elsif i == signal.length - 3
        next_element << char
        elements << parse_signal(next_element)
      else
        next_element << char
      end
    end
  end
  elements
end

def compare(smaller, larger)
  smaller.each_with_index do |small, i|
    large = larger[i]
    return :wrong if large.nil?
    if small.is_a?(Array) && large.is_a?(Array)
      result = compare(small, large)
      return result unless result == :equal
    elsif small.is_a?(Array)
      large = [large]
      result = compare(small, large)
      return result unless result == :equal
    elsif large.is_a?(Array)
      small = [small]
      result = compare(small, large)
      return result unless result == :equal
    else
      return :wrong if large < small
      return :right if small < large
    end
  end
  if larger.length > smaller.length
    return :right
  else
    return :equal
  end
end

index_counter = 0
File.open('input.txt').each_line.map(&:chomp).each_slice(3).each_with_index do |group, i|
  index_counter += i+1 if compare(parse_signal(group[0]), parse_signal(group[1])) == :right
end
pp index_counter
