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
    instruction.to_i.times do
      x_mod = 0
      y_mod = 0
      if %(L R).include?(facing)
        x_mod = facing == 'L' ? -1 : 1
      else
        y_mod = facing == 'U' ? -1 : 1
      end
      provisional_facing = facing
      x, y = [coords[0] + x_mod, coords[1] + y_mod]
      if y < 0
        if x >= 50 && x <= 99
          x -= 50
          y = 150 + x
          x = 0
          provisional_facing = 'R'
        elsif x >= 100 && x <= 149
          x -= 100
          y = map.length - 1
        end
      elsif y == map.length
        x += 100
        y = 0
      elsif x < 0
        if y >= 100 && y <= 149
          x = 50
          y = 149 - y
          provisional_facing = 'R'
        elsif y >= 150 && y <= 199
          y -= 150
          x = 50 + y
          y = 0
          provisional_facing = 'D'
        end
      elsif map[y][x].nil?
        if x == 49
          if y >= 0 && y <= 49
            x = 0
            y = 49 - y + 100
            provisional_facing = 'R'
          elsif y >= 50 && y <= 99
            x = y - 50
            y = 100
            provisional_facing = 'D'
          end
        elsif x == 150
          y = 49 - y + 100
          x = 99
          provisional_facing = 'L'
        elsif y == 50
          y = x - 50
          x = 99
          provisional_facing = 'L'
        elsif x == 100
          if y >= 50 && y <= 99
            x = y + 50
            y = 49
            provisional_facing = 'U'
          elsif y >= 100 && y <= 149
            y = 149 - y
            x = 149
            provisional_facing = 'L'
          end
        elsif y == 99
          y = x + 50
          x = 50
          provisional_facing = 'R'
        elsif y == 150
          y = x + 100
          x = 49
          provisional_facing = 'L'
        elsif x == 50
          x = y - 100
          y = 149
          provisional_facing = 'U'
        end
      end
      break if map[y][x] == '#'
      coords = [x, y]
      facing = provisional_facing
    end
  end
end

pp ((coords[1]+1) * 1000) + ((coords[0]+1) * 4) + directions.find_index{|d| d == facing}

pp "Finished in: #{Time.now - start}s"
