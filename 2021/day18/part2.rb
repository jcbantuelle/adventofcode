require 'pp'

def magnitude(number)
  while number.include?(']') do
    end_index = number.index(']')
    segment = number.match(/\[(\d+),(\d+)\]/)
    magnitude = (segment[1].to_i * 3 + segment[2].to_i * 2).to_s
    number[end_index-(segment[0].length-1)..end_index] = magnitude
  end
  number
end

def explode(result, index)
  match_segment = result[0..index].match(/\[(\d+),(\d+)\]$/)
  prior_segment = result[0..index-match_segment[0].length]
  next_segment = result[index+1..-1]

  prior_index = prior_segment.index(/\d+(?!.*\d+)/)
  prior_sum = nil
  unless prior_index.nil?
    prior_digit = prior_segment[prior_index..prior_segment.length].match(/(\d+)/)[1]
    prior_sum = (prior_digit.to_i + match_segment[1].to_i).to_s
    prior_segment[prior_index..prior_index+(prior_digit.length-1)] = prior_sum
  end

  next_index = next_segment.index(/\d/)
  next_sum = nil
  unless next_index.nil?
    next_digit = next_segment.match(/(\d+)/)[1]
    next_sum = (next_digit.to_i + match_segment[2].to_i).to_s
    next_segment[next_index..next_index+(next_digit.length-1)] = next_sum
  end

  prior_segment + '0' + next_segment
end

def split(result, current_digit)
  digit = current_digit[0].to_i
  left = (digit/2.0).floor
  right = (digit/2.0).ceil
  prior_segment = result[0..current_digit[1]-1]
  next_segment = result[current_digit[1]+current_digit[0].length..-1]
  modified_segment = "[#{left},#{right}]"
  prior_segment + modified_segment + next_segment
end

def reduce(result)
  depth = 0
  explosion = false
  result.each_char.to_a.each_with_index do |letter, index|
    if letter == '['
      depth += 1
    elsif letter == ']'
      if depth > 4
        explosion = true
        result = explode(result.dup, index)
        break
      else
        depth -= 1
      end
    end
  end
  unless explosion
    current_digit = [nil,nil]
    result.each_char.to_a.each_with_index do |letter, index|
      if letter.match(/\d/)
        if current_digit[0].nil?
          current_digit[0] = letter
          current_digit[1] = index
        else
          current_digit[0] += letter
        end
      else
        if current_digit[0].nil? || current_digit[0].to_i < 10
          current_digit = [nil, nil]
        else
          result = split(result.dup, current_digit)
          break
        end
      end
    end
  end
  result
end

numbers = []
File.foreach('input.txt') do |line|
  numbers.push(line.chomp)
end

max_magnitude = 0

numbers.each do |number|
  numbers.each do |number2|
    next if number == number2
    result = "[#{number},#{number2}]"
    loop do
      new_result = reduce(result.dup)
      break if new_result == result
      result = new_result
    end
    result_magnitude = magnitude(result).to_i
    max_magnitude = result_magnitude if result_magnitude > max_magnitude
  end
end

pp max_magnitude
