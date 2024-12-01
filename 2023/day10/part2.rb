connections = {
  '|' => ['U', 'D'],
  'J' => ['U', 'L'],
  'L' => ['U', 'R'],
  '7' => ['D', 'L'],
  'F' => ['D', 'R'],
  '-' => ['L', 'R'],
  '.' => []
}

directions = {
  'L' => [0,-1,'R'],
  'R' => [0,1,'L'],
  'U' => [-1,0,'D'],
  'D' => [1,0,'U']
}

start_pos = nil
grid = File.open('input.txt').each_line.map(&:chomp).each_with_index.map{ |line, i|
  row = line.each_char.to_a.map{|cell| [cell, nil, nil]}
  start = row.find_index{|cell| cell[0] == 'S'}
  start_pos = [i, start] if start
  row
}

start_connections = []
if start_pos[0] > 0
  up = grid[start_pos[0]-1][start_pos[1]][0]
  start_connections << 'U' if connections[up].include?('D')
end

if start_pos[0] < grid.length-1
  down = grid[start_pos[0]+1][start_pos[1]][0]
  start_connections << 'D' if connections[down].include?('U')
end

if start_pos[1] > 0
  left = grid[start_pos[0]][start_pos[1]-1][0]
  start_connections << 'L' if connections[left].include?('R')
end

if start_pos[1] < grid[0].length-1
  right = grid[start_pos[0]][start_pos[1]+1][0]
  start_connections << 'R' if connections[right].include?('L')
end
start_value = connections.key(start_connections)
cell = grid[start_pos[0]][start_pos[1]]
cell[0] = start_value
cell[1] = true
cell[2] = true

direction = directions[connections[start_value].first]
current_position = [start_pos[0]+direction[0],start_pos[1]+direction[1]]
cell = grid[current_position[0]][current_position[1]]

while cell[1].nil?
  cell[1] = true
  cell[2] = true
  direction = directions[connections[cell[0]].find{|conn| conn != direction[2]}]
  current_position[0] += direction[0]
  current_position[1] += direction[1]
  cell = grid[current_position[0]][current_position[1]]
end

min_row = grid.length
max_row = -1
min_col = grid[0].length
max_col = -1
grid.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    if cell[1] == true
      min_row = i if i < min_row
      max_row = i if i > max_row
      min_col = j if j < min_col
      max_col = j if j > max_col
    end
  end
end

grid = grid[min_row..max_row]
grid.map!{|row| row[min_col..max_col]}

row = 0
width = grid[0].length
while row < grid.length - 1
  new_row = width.times.each_with_index.map{|_,i|
    if connections[grid[row][i][0]].include?('D') && connections[grid[row+1][i][0]].include?('U')
      ['|', true, true]
    else
      ['.', false, nil]
    end
  }
  grid.insert(row+1, new_row)
  row += 2
end

col = 0
length = grid.length
while col < grid[0].length - 1
  new_col = length.times.each_with_index.map{|_,i|
    if connections[grid[i][col][0]].include?('R') && connections[grid[i][col+1][0]].include?('L')
      ['-', true, true]
    else
      ['.', false, nil]
    end
  }
  new_col.each_with_index do |c, i|
    grid[i].insert(col+1, c)
  end
  col += 2
end

grid.each_with_index do |row, r|
  row.each_with_index do |cell, c|
    if grid[r][c][2].nil?
      evals = [[r,c]]
      tracked = []
      escape = false
      while !evals.empty?
        x,y = evals.pop
        tracked << [x,y]
        grid[x][y][2] = true
        if x-1 >= 0
          check = grid[x-1][y]
          if check[2].nil?
            evals << [x-1,y]
          end
        else
          escape = true
        end
        if x+1 < grid.length
          check = grid[x+1][y]
          if check[2].nil?
            evals << [x+1,y]
          end
        else
          escape = true
        end
        if y-1 >= 0
          check = grid[x][y-1]
          if check[2].nil?
            evals << [x,y-1]
          end
        else
          escape = true
        end
        if y+1 < grid[x].length
          check = grid[x][y+1]
          if check[2].nil?
            evals << [x,y+1]
          end
        else
          escape = true
        end
      end
      unless escape
        tracked.each do |x,y|
          grid[x][y][2] = false
        end
      end
    end
  end
end

puts grid.flatten(1).select{|c| c[1].nil? && c[2] == false}.length
