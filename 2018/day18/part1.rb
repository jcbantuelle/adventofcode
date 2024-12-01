require 'pp'

def get_acre(grid, y, x)
  y < 0 || x < 0 || grid[y].nil? ? nil : grid[y][x]
end

grid = []

File.foreach('input.txt') do |line|
  grid << line.chomp.chars
end

10.times do
  new_grid = grid.map(&:dup)
  grid.each_with_index do |row, y|
    row.each_with_index do |acre, x|
      adjacent_trees = 0
      adjacent_yards = 0
      (y-1).upto(y+1) do |y_mod|
        (x-1).upto(x+1) do |x_mod|
          next if y_mod == y && x_mod == x
          adjacent_acre = get_acre(grid, y_mod, x_mod)
          adjacent_trees += 1 if adjacent_acre == '|'
          adjacent_yards += 1 if adjacent_acre == '#'
        end
      end
      if acre == '.' && adjacent_trees >= 3
        new_grid[y][x] = '|'
      elsif acre == '|' && adjacent_yards >= 3
        new_grid[y][x] = '#'
      elsif acre == '#' && (adjacent_yards == 0 || adjacent_trees == 0)
        new_grid[y][x] = '.'
      end
    end
  end
  grid = new_grid
end

trees = 0
yards = 0
grid.flatten.each {|acre|
  trees += 1 if acre == '|'
  yards += 1 if acre == '#'
}

pp trees*yards
