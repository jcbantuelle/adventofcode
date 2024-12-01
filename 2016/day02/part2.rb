require 'pp'

keypad = [
  ['','','1','',''],
  ['','2','3','4',''],
  ['5','6','7','8','9'],
  ['','A','B','C',''],
  ['','','D','','']
]

instructions = []

File.foreach('input.txt') do |line|
  instructions.push(line.chomp)
end

code = ''
position = [3,0]

instructions.each do |instruction|
  instruction.each_char do |direction|
    if direction == 'U'
      if position[0] > 0
        keypad_value = keypad[position[0]-1][position[1]]
        position[0] -= 1 unless keypad_value.empty?
      end
    elsif direction == 'D'
      if position[0] < 4
        keypad_value = keypad[position[0]+1][position[1]]
        position[0] += 1 unless keypad_value.empty?
      end
    elsif direction == 'L'
      if position[1] > 0
        keypad_value = keypad[position[0]][position[1]-1]
        position[1] -= 1 unless keypad_value.empty?
      end
    elsif direction == 'R'
      if position[1] < 4
        keypad_value = keypad[position[0]][position[1]+1]
        position[1] += 1 unless keypad_value.empty?
      end
    end
  end
  code += keypad[position[0]][position[1]].to_s
end

puts code
