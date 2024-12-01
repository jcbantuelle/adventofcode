require 'pp'

instructions = []
registers = {
  'a' => 7,
  'b' => 0,
  'c' => 0,
  'd' => 0
}
register_labels = %w{a b c d}

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
  elsif instruction[0] == 'tgl'
    toggle_index = register_labels.include?(instruction[1]) ? registers[instruction[1]] : instruction[1].to_i
    toggle_index += instruction_index
    instruction_index += 1
    next if toggle_index < 0
    toggle_instruction = instructions[toggle_index]
    next if toggle_instruction.nil?
    if toggle_instruction[0] == 'inc'
      toggle_instruction[0] = 'dec'
    elsif %w{dec tgl}.include?(toggle_instruction[0])
      toggle_instruction[0] = 'inc'
    elsif toggle_instruction[0] == 'jnz'
      toggle_instruction[0] = 'cpy'
    elsif toggle_instruction[0] == 'cpy'
      toggle_instruction[0] = 'jnz'
    end
  end
end

pp registers['a']
