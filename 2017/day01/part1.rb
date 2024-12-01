require 'pp'

sequence = nil

File.foreach('input.txt') do |line|
  sequence = line.chomp
  break
end

total = 0

sequence.each_char.to_a.each_with_index do |digit, index|
  if sequence[index+1].nil?
    total += digit.to_i if digit == sequence[0]
  else
    total += digit.to_i if digit == sequence[index+1]
  end
end

pp total
