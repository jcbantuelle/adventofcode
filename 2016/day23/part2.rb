require 'pp'

instructions = []
registers = {
  'a' => 12,
  'b' => 0,
  'c' => 0,
  'd' => 0
}
register_labels = %w{a b c d}

File.foreach('input-modified.txt') do |line|
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
  elsif instruction[0] == 'mul'
    left = register_labels.include?(instruction[1]) ? registers[instruction[1]] : instruction[1].to_i
    right = register_labels.include?(instruction[2]) ? registers[instruction[2]] : instruction[2].to_i
    registers[instruction[3]] = left * right
    instruction_index += 1
  elsif instruction[0] == 'cpy'
    instruction_index += 1
    next unless register_labels.include?(instruction[2])
    if register_labels.include?(instruction[1])
      registers[instruction[2]] = registers[instruction[1]]
    else
      registers[instruction[2]] = instruction[1].to_i
    end
  elsif instruction[0] == 'jnz'
    non_zero = register_labels.include?(instruction[1]) ? registers[instruction[1]] : instruction[1].to_i
    if non_zero == 0
      instruction_index += 1
    else
      jump = register_labels.include?(instruction[2]) ? registers[instruction[2]] : instruction[2].to_i
      instruction_index += jump
    end
  end
end

pp registers['a']
