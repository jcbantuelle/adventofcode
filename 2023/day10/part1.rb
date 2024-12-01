require 'pp'

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
  row = line.each_char.to_a.map{|cell| [cell, nil]}
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
cell[1] = 0

connections[start_value].each do |walk|
  direction = directions[walk]
  current_position = [start_pos[0]+direction[0],start_pos[1]+direction[1]]
  cell = grid[current_position[0]][current_position[1]]
  steps = 1

  while cell[1] != 0
    cell[1] = steps if cell[1].nil? || cell[1] > steps
    steps += 1
    direction = directions[connections[cell[0]].find{|conn| conn != direction[2]}]
    current_position[0] += direction[0]
    current_position[1] += direction[1]
    cell = grid[current_position[0]][current_position[1]]
  end
end

pp grid.flatten(1).map{|cell| cell[1]}.compact.sort[-1]
