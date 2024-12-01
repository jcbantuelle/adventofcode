require 'pp'

horizontal = 0
depth = 0

File.foreach('input.txt') do |line|
  input = line.match(/([a-z]*)\s(\d)*/)
  instruction = input[1]
  amount = input[2].to_i
  horizontal += amount if instruction == 'forward'
  depth += amount if instruction == 'down'
  depth -= amount if instruction == 'up'
end

puts horizontal*depth
