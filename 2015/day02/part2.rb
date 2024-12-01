require 'pp'

total = 0

File.foreach('input.txt') do |line|
  dimensions = line.chomp.split('x').map(&:to_i).sort
  total += dimensions[0]*2 + dimensions[1]*2 + dimensions.inject(&:*)
end

pp total
