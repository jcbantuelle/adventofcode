require 'pp'

size = 1000

grid = Array.new(size)
0.upto(size-1) do |index|
  grid[index] = Array.new(size, 0)
end

File.foreach('input.txt') do |line|
  coords = line.chomp.split(' -> ')
  left_coords = coords[0].split(',').map(&:to_i)
  right_coords = coords[1].split(',').map(&:to_i)
  if left_coords[0] == right_coords[0]
    x_index = left_coords[0]
    y_coords = [left_coords[1], right_coords[1]]
    start = y_coords.min
    stop = y_coords.max
    start.upto(stop) do |y_index|
      grid[y_index][x_index] += 1
    end
  elsif left_coords[1] == right_coords[1]
    y_index = left_coords[1]
    x_coords = [left_coords[0], right_coords[0]]
    start = x_coords.min
    stop = x_coords.max
    start.upto(stop) do |x_index|
      grid[y_index][x_index] += 1
    end
  else
    x_index = left_coords[0]
    x_mod = x_index < right_coords[0] ? 1 : -1
    y_index = left_coords[1]
    y_mod = y_index < right_coords[1] ? 1 : -1

    ((left_coords[0] - right_coords[0]).abs+1).times do |count|
      grid[y_index][x_index] += 1
      x_index += (1 * x_mod)
      y_index += (1 * y_mod)
    end
  end
end

pp grid.flatten.select{|cell| cell > 1}.length
