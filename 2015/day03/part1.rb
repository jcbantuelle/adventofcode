require 'pp'

directions = nil
grid = [[1]]
x_coord = 0
y_coord = 0

File.foreach('input.txt') do |line|
  directions = line.chomp
  break
end

directions.each_char do |direction|
  if direction == '>'
    x_coord += 1
    if grid[y_coord][x_coord].nil?
      0.upto(grid.length-1) do |index|
        grid[index].push(0)
      end
    end
    grid[y_coord][x_coord] += 1
  elsif direction == '^'
    y_coord -= 1
    if y_coord < 0
      fill_size = grid[0].length
      grid.unshift(Array.new(fill_size,0))
      y_coord = 0
    end
    grid[y_coord][x_coord] += 1
  elsif direction == 'v'
    y_coord += 1
    if grid[y_coord].nil?
      fill_size = grid[0].length
      grid.push(Array.new(fill_size,0))
    end
    grid[y_coord][x_coord] += 1
  elsif direction == '<'
    x_coord -= 1
    if x_coord < 0
      0.upto(grid.length-1) do |index|
        grid[index].unshift(0)
      end
      x_coord = 0
    end
    grid[y_coord][x_coord] += 1
  end
end

pp grid.flatten.select{|house| house > 0}.length
