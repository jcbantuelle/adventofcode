require 'pp'

instructions = []
registers = {
  'a' => 0,
  'b' => 0,
  'c' => 0,
  'd' => 0
}

File.foreach('input.txt') do |line|
  instructions.push(line.chomp.split(' '))
end

instruction_index = 0

while instruction_index < instructions.length do
  instruction = instructions[instruction_index]
  if instruction[0] == 'inc'
    registers[instruction[1]] += 1
    instruction_index += 1
  elsif instruction[0] == 'dec'
    registers[instruction[1]] -= 1
    instruction_index += 1
  elsif instruction[0] == 'cpy'
    if %w{a b c d}.include?(instruction[1])
      registers[instruction[2]] = registers[instruction[1]]
    else
      registers[instruction[2]] = instruction[1].to_i
    end
    instruction_index += 1
  elsif instruction[0] == 'jnz'
    if registers[instruction[1]] == 0
      instruction_index += 1
    else
      instruction_index += instruction[2].to_i
    end
  end
end

pp registers['a']
