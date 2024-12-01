require 'pp'

instructions = {}

File.foreach('input.txt') do |line|
  instruction = line.chomp.split(' ')
  step = instruction[7]
  dependency = instruction[1]
  instructions[step] ||= []
  instructions[step].push(dependency)
end

(instructions.values.flatten.uniq - instructions.keys).each do |step|
  instructions[step] = []
end

order = ''

while !instructions.empty? do
  next_step = instructions.select{|step,dependencies|
    dependencies.empty?
  }.keys.sort.first

  order += next_step

  instructions.each do |step, instruction|
    instruction.delete(next_step)
  end

  instructions.delete(next_step)
end

pp order
