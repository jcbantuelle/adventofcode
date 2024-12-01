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
    contents = []
    coords.each_with_index do |coord, index|
      distance = (coord[0] - x_coord).abs + (coord[1] - y_coord).abs
      contents.push([index, distance])
    end
    grid[y_coord][x_coord] = contents
  end
end

min_distance_grid = grid.map{ |row|
  row.map { |cell|
    min_distance = cell.min{|distance1, distance2| distance1[1] <=> distance2[1]}
    min_cells = cell.reject{|distance| distance[1] != min_distance[1]}
    min_cells.length > 1 ? '.' : min_distance[0]
  }
}

bad_values = (min_distance_grid.first + min_distance_grid.last + min_distance_grid.map{|row| [row.first, row.last]}.flatten).uniq
pp min_distance_grid.flatten.reject{|cell| bad_values.include?(cell)}.group_by{|cell| cell}.map{|key, value| value.length}.sort.last
