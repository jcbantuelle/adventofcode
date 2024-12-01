require 'pp'

instructions = []

registers = {
  'a' => 1,
  'b' => 0
}

File.foreach('input.txt') do |line|
  instruction = line.chomp
  if instruction.include?(',')
    instruction = instruction.split(',')
    jmp = instruction[1].strip.match(/([\-\+])(\d*)/)
    instruction = instruction[0].split(' ')
    instructions.push([instruction[0], instruction[1], jmp[1], jmp[2].to_i])
  else
    instruction = instruction.split(' ')
    if %w(jmp jie jio).include?(instruction[0])
      jmp = instruction[1].strip.match(/([\-\+])(\d*)/)
      instructions.push([instruction[0], jmp[1], jmp[2].to_i])
    else
      instructions.push([instruction[0], instruction[1]])
    end
  end
end

instruction_index = 0

loop do
  instruction = instructions[instruction_index]
  break if instruction_index < 0 || instruction.nil?
  if instruction[0] == 'inc'
    registers[instruction[1]] += 1
    instruction_index += 1
  elsif instruction[0] == 'hlf'
    registers[instruction[1]] /= 2
    instruction_index += 1
  elsif instruction[0] == 'tpl'
    registers[instruction[1]] *= 3
    instruction_index += 1
  elsif instruction[0] == 'jmp'
    index_mod = instruction[2]
    index_mod *= -1 if instruction[1] == '-'
    instruction_index += index_mod
  elsif instruction[0] == 'jio'
    if registers[instruction[1]] == 1
      index_mod = instruction[3]
      index_mod *= -1 if instruction[2] == '-'
      instruction_index += index_mod
    else
      instruction_index += 1
    end
  elsif instruction[0] == 'jie'
    if registers[instruction[1]] % 2 == 0
      index_mod = instruction[3]
      index_mod *= -1 if instruction[2] == '-'
      instruction_index += index_mod
    else
      instruction_index += 1
    end
  end
end

pp registers
