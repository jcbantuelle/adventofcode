require 'pp'

instructions = []

File.foreach('input.txt') do |line|
  instructions.push(line.chomp.to_i)
end

steps = 0
current_instruction = 0

while current_instruction >= 0 && current_instruction < instructions.length do
  offset = instructions[current_instruction]
  if offset > 2
    instructions[current_instruction] -= 1
  else
    instructions[current_instruction] += 1
  end
  steps += 1
  current_instruction += offset
end

pp steps
