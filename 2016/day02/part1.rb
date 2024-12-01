require 'pp'

keypad = [
  [1,2,3],
  [4,5,6],
  [7,8,9]
]

instructions = []

File.foreach('input.txt') do |line|
  instructions.push(line.chomp)
end

code = ''
position = [1,1]

instructions.each do |instruction|
  instruction.each_char do |direction|
    if direction == 'U'
      position[0] -= 1 if position[0] > 0
    elsif direction == 'D'
      position[0] += 1 if position[0] < 2
    elsif direction == 'L'
      position[1] -= 1 if position[1] > 0
    elsif direction == 'R'
      position[1] += 1 if position[1] < 2
    end
  end
  code += keypad[position[0]][position[1]].to_s
end

puts code
