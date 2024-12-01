require 'pp'

map = []
facing = 'R'
directions = ['R', 'D', 'L', 'U']
is_map = true
instructions = nil

inputs = File.open('input.txt').each_line{ |line|
  if is_map
    row = line.chomp
    if row.nil? || row.empty?
      is_map = false
    else
      map << row.chars.map{|cell|
        if cell == ' '
          nil
        else
          cell
        end
      }
    end
  else
    instructions = line.chomp.gsub(/\d+/){ |instruction| "#{instruction},"}.gsub(/[LR]/){|instruction| "#{instruction},"}[0..-2].split(',')
  end
}

start = Time.now
coords = [map[0].find_index{|cell| cell == '.'}, 0]

instructions.each do |instruction|
  if %w(L R).include?(instruction)
    current_dir = directions.find_index{|d| d == facing}
    new_dir = current_dir + (instruction == 'L' ? -1 : 1)
    new_dir = 0 if new_dir == 4
    facing = directions[new_dir]
  else
    x_mod = 0
    y_mod = 0
    if %(L R).include?(facing)
      x_mod = facing == 'L' ? -1 : 1
    else
      y_mod = facing == 'U' ? -1 : 1
    end
    instruction.to_i.times do
      x, y = [coords[0] + x_mod, coords[1] + y_mod]
      y = map.length - 1 if y < 0
      y = 0 if y == map.length
      x = map[y].length - 1 if x < 0
      x = 0 if x == map[y].length
      while map[y].nil? || map[y][x].nil?
        x += x_mod
        y += y_mod
        y = map.length - 1 if y < 0
        y = 0 if y == map.length
        x = map[y].length - 1 if x < 0
        x = 0 if x == map[y].length
      end
      break if map[y][x] == '#'
      coords = [x, y]
    end
  end
end

pp ((coords[1]+1) * 1000) + ((coords[0]+1) * 4) + directions.find_index{|d| d == facing}

pp "Finished in: #{Time.now - start}s"
