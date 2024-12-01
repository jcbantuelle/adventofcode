require 'pp'

sequence = nil

File.foreach('input.txt') do |line|
  sequence = line.chomp
  break
end

total = 0
full_length = sequence.length
forward = full_length / 2

sequence.each_char.to_a.each_with_index do |digit, index|
  compare_index = index + forward
  compare_index -= full_length if compare_index >= full_length
  total += digit.to_i if digit == sequence[compare_index]
end

pp total
