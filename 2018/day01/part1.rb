require 'pp'

frequency = 0

File.foreach('input.txt') do |line|
  frequency += line.chomp.to_i
end

pp frequency
