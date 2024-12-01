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
visited = [[0,0]]

File.foreach('input.txt') do |line|
  instructions = line.chomp.split(', ')
  break
end

instructions.each do |instruction|
  change = instruction[0]
  blocks = instruction.slice(1,instruction.length).to_i
  direction = turn(direction, change)
  if direction == 'N'
    blocks.times do |block|
      blocks_up_down += 1
      new_coords = [blocks_left_right,  blocks_up_down]
      if visited.include?(new_coords)
        pp new_coords[0].abs + new_coords[1].abs
        exit
      else
        visited.push(new_coords)
      end
    end
  elsif direction == 'S'
    blocks.times do |block|
      blocks_up_down -= 1
      new_coords = [blocks_left_right,  blocks_up_down]
      if visited.include?(new_coords)
        pp new_coords[0].abs + new_coords[1].abs
        exit
      else
        visited.push(new_coords)
      end
    end
  elsif direction == 'W'
    blocks.times do |block|
      blocks_left_right -= 1
      new_coords = [blocks_left_right,  blocks_up_down]
      if visited.include?(new_coords)
        pp new_coords[0].abs + new_coords[1].abs
        exit
      else
        visited.push(new_coords)
      end
    end
  elsif direction == 'E'
    blocks.times do |block|
      blocks_left_right += 1
      new_coords = [blocks_left_right,  blocks_up_down]
      if visited.include?(new_coords)
        pp new_coords[0].abs + new_coords[1].abs
        exit
      else
        visited.push(new_coords)
      end
    end
  end
end
