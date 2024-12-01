require 'pp'

grid = []
File.foreach('input.txt') do |line|
  grid.push(line.chomp.each_char.to_a)
end

count = 0
loop do
  count += 1
  old_grid = grid.map(&:dup)
  new_grid = grid.map(&:dup)
  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      if cell == '>'
        next_index = grid[y][x+1].nil? ? 0 : x+1
        if grid[y][next_index] == '.'
          new_grid[y][x] = '.'
          new_grid[y][next_index] = '>'
        end
      end
    end
  end
  grid = new_grid
  new_grid = grid.map(&:dup)
  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      if cell == 'v'
        next_index = grid[y+1].nil? ? 0 : y+1
        if grid[next_index][x] == '.'
          new_grid[y][x] = '.'
          new_grid[next_index][x] = 'v'
        end
      end
    end
  end
  break if new_grid == old_grid
  grid = new_grid
end

pp count
