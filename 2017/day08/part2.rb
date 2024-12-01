require 'pp'

registers = {}
largest = 0

File.foreach('input.txt') do |line|
  instruction = line.chomp.split(' ')
  target_register = instruction[0]
  conditional_register = instruction[4]
  registers[target_register] ||= 0
  registers[conditional_register] ||= 0
  if registers[conditional_register].send(instruction[5], instruction[6].to_i)
    if instruction[1] == 'inc'
      registers[target_register] += instruction[2].to_i
    else
      registers[target_register] -= instruction[2].to_i
    end
    largest = registers[target_register] if registers[target_register] > largest
  end
end

pp largest
