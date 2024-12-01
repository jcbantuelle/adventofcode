require 'pp'

instructions = []
instruction_index = 0
$registers = {}
multiplications = 0

def value(input)
  if input.match(/[a-z]+/)
    $registers[input] ||= 0
    $registers[input]
  else
    input.to_i
  end
end

File.foreach('input.txt') do |line|
  instructions.push(line.chomp.split(' '))
end

while instruction_index > -1 && instruction_index < instructions.length do
  instruction = instructions[instruction_index]
  if instruction[0] == 'set'
    $registers[instruction[1]] = value(instruction[2])
  elsif instruction[0] == 'sub'
    $registers[instruction[1]] = value(instruction[1]) - value(instruction[2])
  elsif instruction[0] == 'mul'
    $registers[instruction[1]] = value(instruction[1]) * value(instruction[2])
    multiplications += 1
  elsif instruction[0] == 'jnz'
    if value(instruction[1]) != 0
      instruction_index += value(instruction[2])
      next
    end
  end
  instruction_index += 1
end

pp multiplications
