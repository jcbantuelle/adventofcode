require 'pp'

lights = Array.new

File.foreach('input.txt') do |line|
  lights.push(line.chomp.each_char.to_a.map{|light| light == '#' ? 1 : 0})
end

100.times do
  new_grid = lights.map{|row| row.dup}
  lights.each_with_index do |row, y_coord|
    row.each_with_index do |light, x_coord|
      on_neighbors = 0
      -1.upto(1) do |y_mod|
        -1.upto(1) do |x_mod|
          next if y_mod == 0 && x_mod == 0
          y_check = y_coord + y_mod
          x_check = x_coord + x_mod
          next if y_check < 0 || x_check < 0 || lights[y_check].nil? || lights[y_check][x_check].nil?
          on_neighbors += lights[y_check][x_check]
        end
      end
      if lights[y_coord][x_coord] == 1
        new_grid[y_coord][x_coord] = [2,3].include?(on_neighbors) ? 1 : 0
      else
        new_grid[y_coord][x_coord] = on_neighbors == 3 ? 1 : 0
      end
    end
  end
  lights = new_grid
end

pp lights.flatten.inject(&:+)
