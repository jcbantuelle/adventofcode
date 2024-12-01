require 'pp'

directions = nil
grid = [[2]]
x_coords = [0,0]
y_coords = [0,0]
counter = 0
santa_turn = 0

File.foreach('input.txt') do |line|
  directions = line.chomp
  break
end

directions.each_char do |direction|
  santa_turn = counter % 2
  if direction == '>'
    x_coords[santa_turn] += 1
    if grid[y_coords[santa_turn]][x_coords[santa_turn]].nil?
      0.upto(grid.length-1) do |index|
        grid[index].push(0)
      end
    end
    grid[y_coords[santa_turn]][x_coords[santa_turn]] += 1
  elsif direction == '^'
    y_coords[santa_turn] -= 1
    if y_coords[santa_turn] < 0
      fill_size = grid[0].length
      grid.unshift(Array.new(fill_size,0))
      y_coords[santa_turn] = 0
      y_coords[(santa_turn+1)%2] += 1
    end
    grid[y_coords[santa_turn]][x_coords[santa_turn]] += 1
  elsif direction == 'v'
    y_coords[santa_turn] += 1
    if grid[y_coords[santa_turn]].nil?
      fill_size = grid[0].length
      grid.push(Array.new(fill_size,0))
    end
    grid[y_coords[santa_turn]][x_coords[santa_turn]] += 1
  elsif direction == '<'
    x_coords[santa_turn] -= 1
    if x_coords[santa_turn] < 0
      0.upto(grid.length-1) do |index|
        grid[index].unshift(0)
      end
      x_coords[santa_turn] = 0
      x_coords[(santa_turn+1)%2] += 1
    end
    grid[y_coords[santa_turn]][x_coords[santa_turn]] += 1
  end
  counter += 1
end

pp grid.flatten.select{|house| house > 0}.length
