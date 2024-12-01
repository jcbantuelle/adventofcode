require 'pp'

dots = []
folds = []

File.foreach('input.txt') do |line|
  line = line.chomp
  if line.include?(',')
    dots.push(line.split(',').map(&:to_i))
  elsif !line.empty?
    fold = line.match(/([x|y])=(\d+)/)
    folds.push([fold[1],fold[2].to_i])
  end
end

max_x = dots.map{|dot| dot[0]}.max+1
max_y = dots.map{|dot| dot[1]}.max+1

grid = []
max_y.times do |y|
  grid.push(Array.new(max_x, 0))
end

dots.each do |dot|
  grid[dot[1]][dot[0]] = 1
end

folds.each do |fold|
  if fold[0] == 'y'
    new_grid = grid[0..(fold[1]-1)].map{|row| row.dup}
    other_grid = grid[(fold[1]+1)..grid.length].map{|row| row.dup}.reverse
  else
    new_grid = grid.map{|row| row[0..(fold[1]-1)].dup}
    other_grid = grid.map{|row| row[(fold[1]+1)..row.length].reverse}
  end
  other_grid.each_with_index do |row, y_coord|
    row.each_with_index do |dot, x_coord|
      new_grid[y_coord][x_coord] = 1 if dot == 1
    end
  end
  grid = new_grid
end

pp grid.map{|row|row.map{|dot|dot == 0 ? '.' : '#'}.join('')}
