require 'pp'

aim = 0
horizontal = 0
depth = 0

File.foreach('input.txt') do |line|
  input = line.match(/([a-z]*)\s(\d)*/)
  instruction = input[1]
  amount = input[2].to_i
  if instruction == 'forward'
    horizontal += amount
    depth += amount * aim
  end
  aim += amount if instruction == 'down'
  aim -= amount if instruction == 'up'
end

puts horizontal*depth
