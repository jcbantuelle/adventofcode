require 'pp'

def turn(direction, change)
  if direction == 'N'
    change == 'L' ? 'W' : 'E'
  elsif direction == 'S'
    change == 'L' ? 'E' : 'W'
  elsif direction == 'W'
    change == 'L' ? 'S' : 'N'
  elsif direction == 'E'
    change == 'L' ? 'N' : 'S'
  end
end

blocks_up_down = 0
blocks_left_right = 0
direction = 'N'
instructions = nil

File.foreach('input.txt') do |line|
  instructions = line.chomp.split(', ')
  break
end

instructions.each do |instruction|
  change = instruction[0]
  blocks = instruction.slice(1,instruction.length).to_i
  direction = turn(direction, change)
  if direction == 'N'
    blocks_up_down += blocks
  elsif direction == 'S'
    blocks_up_down -= blocks
  elsif direction == 'W'
    blocks_left_right -= blocks
  elsif direction == 'E'
    blocks_left_right += blocks
  end
end

pp blocks_up_down.abs+blocks_left_right.abs
