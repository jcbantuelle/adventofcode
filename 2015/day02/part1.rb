require 'pp'

total = 0

File.foreach('input.txt') do |line|
  dimensions = line.chomp.split('x').map(&:to_i).sort
  total += (dimensions[0] * dimensions[1]) + (dimensions[0] * dimensions[1] * 2) + (dimensions[0] * dimensions[2] * 2) + (dimensions[1] * dimensions[2] * 2)
end

pp total
