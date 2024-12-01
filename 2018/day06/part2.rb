require 'pp'

coords = []

File.foreach('input.txt') do |line|
  coords.push(line.chomp.split(', ').map(&:to_i))
end

max_x = coords.map{|coord| coord[0]}.max
max_y = coords.map{|coord| coord[1]}.max

grid = Array.new
0.upto(max_y+1) do |y_coord|
  grid[y_coord] = Array.new
  0.upto(max_x+1) do |x_coord|
    grid[y_coord][x_coord] = coords.map{ |coord|
      (coord[0] - x_coord).abs + (coord[1] - y_coord).abs
    }.inject(&:+)
  end
end

pp grid.flatten.select{|value| value < 10000}.length
