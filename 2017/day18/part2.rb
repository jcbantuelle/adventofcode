require 'pp'

instructions = []
index0 = 0
index1 = 0
send0 = []
send1 = []
registers0 = {'p' => 0}
registers1 = {'p' => 1}
wait0 = false
wait1 = false
done0 = false
done1 = false
sent = 0

def value(registers, input)
  if input.match(/[a-z]+/)
    registers[input] ||= 0
    registers[input]
  else
    input.to_i
  end
end

File.foreach('input.txt') do |line|
  instructions.push(line.chomp.split(' '))
end

while (!wait0 && !done0) || (!wait1 && !done1) do
  if !done0
    instruction = instructions[index0]
    if instruction[0] == 'snd'
      send0.push(value(registers0, instruction[1]))
      index0 += 1
    elsif instruction[0] == 'set'
      registers0[instruction[1]] = value(registers0, instruction[2])
      index0 += 1
    elsif instruction[0] == 'add'
      registers0[instruction[1]] = value(registers0, instruction[1]) + value(registers0, instruction[2])
      index0 += 1
    elsif instruction[0] == 'mul'
      registers0[instruction[1]] = value(registers0, instruction[1]) * value(registers0, instruction[2])
      index0 += 1
    elsif instruction[0] == 'mod'
      registers0[instruction[1]] = value(registers0, instruction[1]) % value(registers0, instruction[2])
      index0 += 1
    elsif instruction[0] == 'rcv'
      if send1.length > 0
        registers0[instruction[1]] = send1.shift
        index0 += 1
        wait0 = false
      else
        wait0 = true
      end
    elsif instruction[0] == 'jgz'
      if value(registers0, instruction[1]) > 0
        index0 += value(registers0, instruction[2])
      else
        index0 += 1
      end
    end
    done0 = index0 < 0 || index0 >= instructions.length
  end

  if !done1
    instruction = instructions[index1]
    if instruction[0] == 'snd'
      send1.push(value(registers1, instruction[1]))
      index1 += 1
      sent += 1
    elsif instruction[0] == 'set'
      registers1[instruction[1]] = value(registers1, instruction[2])
      index1 += 1
    elsif instruction[0] == 'add'
      registers1[instruction[1]] = value(registers1, instruction[1]) + value(registers1, instruction[2])
      index1 += 1
    elsif instruction[0] == 'mul'
      registers1[instruction[1]] = value(registers1, instruction[1]) * value(registers1, instruction[2])
      index1 += 1
    elsif instruction[0] == 'mod'
      registers1[instruction[1]] = value(registers1, instruction[1]) % value(registers1, instruction[2])
      index1 += 1
    elsif instruction[0] == 'rcv'
      if send0.length > 0
        registers1[instruction[1]] = send0.shift
        index1 += 1
        wait1 = false
      else
        wait1 = true
      end
    elsif instruction[0] == 'jgz'
      if value(registers1, instruction[1]) > 0
        index1 += value(registers1, instruction[2])
      else
        index1 += 1
      end
    end
    done1 = index1 < 0 || index1 >= instructions.length
  end
end

pp sent
