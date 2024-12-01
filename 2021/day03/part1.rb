require 'pp'

digit_tally = []

File.foreach('input.txt') do |line|
  line.chars.each_with_index do |char, index|
    digit = char.to_i
    digit_tally[index] = [0,0] if digit_tally[index].nil?
    digit_tally[index][digit] += 1
  end
end

digit_tally.pop

gamma = ''
epsilon = ''

digit_tally.each do |digit|
  if digit[0] > digit[1]
    gamma += '0'
    epsilon += '1'
  else
    gamma += '1'
    epsilon += '0'
  end
end

puts gamma.to_i(2) * epsilon.to_i(2)
