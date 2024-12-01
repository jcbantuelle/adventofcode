require 'pp'

instructions = []
File.foreach('input.txt') do |line|
  instructions.push(line.chomp.split(' '))
end

a_count = 0
loop do
  output_index = 0
  instruction_index = 0
  registers = {
    'a' => a_count,
    'b' => 0,
    'c' => 0,
    'd' => 0
  }
  register_labels = %w{a b c d}
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
    elsif instruction[0] == 'out'
      if registers['b'] == output_index % 2
        if output_index == 20
          pp a_count
          exit
        end
        output_index += 1
        instruction_index += 1
      else
        a_count += 1
        break
      end
    end
  end
end
