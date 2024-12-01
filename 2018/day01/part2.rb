require 'pp'

frequency = 0
frequency_list = []
frequency_index = 0
memo = {}

File.foreach('input.txt') do |line|
  frequency_list.push(line.chomp.to_i)
end

while memo[frequency.to_s].nil?
  memo[frequency.to_s] = true
  frequency += frequency_list[frequency_index]
  frequency_index += 1
  frequency_index = 0 if frequency_index == frequency_list.length
end

pp frequency
