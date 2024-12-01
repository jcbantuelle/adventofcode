require 'pp'

instructions = []

File.foreach('input.txt') do |line|
  instructions.push(line.chomp.to_i)
end

steps = 0
current_instruction = 0

while current_instruction >= 0 && current_instruction < instructions.length do
  offset = instructions[current_instruction]
  instructions[current_instruction] += 1
  steps += 1
  current_instruction += offset
end

pp steps
