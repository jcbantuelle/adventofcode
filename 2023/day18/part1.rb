require 'pp'

# Input
row = 147
col = 3

fill_start_row = 1
fill_start_col = 150

# Test
# row = 0
# col = 0

# fill_start_row = 1
# fill_start_col = 1

grid = []
grid[row] = []

File.open('input.txt').each_line{ |line|
  dir, len, hex = line.chomp.split(' ')
  len = len.to_i
  if dir == 'U'
    new_row = row - len
    (row-1).downto(new_row) do |r|
      grid[r] = [] if grid[r].nil?
      grid[r][col] = '#'
    end
    row = new_row
  elsif dir == 'D'
    new_row = row + len
    (row+1).upto(new_row) do |r|
      grid[r] = [] if grid[r].nil?
      grid[r][col] = '#'
    end
    row = new_row
  elsif dir == 'L'
    new_col = col - len
    (col-1).downto(new_col) do |c|
      grid[row][c] = '#'
    end
    col = new_col
  elsif dir == 'R'
    new_col = col + len
    (col+1).upto(new_col) do |c|
      grid[row][c] = '#'
    end
    col = new_col
  end
}

fills = [[fill_start_row,fill_start_col]]
while !fills.empty?
  row, col = fills.shift
  next unless grid[row][col].nil?
  grid[row][col] = '#'
  if grid[row-1][col].nil?
    fills << [row-1,col]
  end
  if grid[row+1][col].nil?
    fills << [row+1,col]
  end
  if grid[row][col-1].nil?
    fills << [row,col-1]
  end
  if grid[row][col+1].nil?
    fills << [row,col+1]
  end
end

pp grid.flatten.compact.length
