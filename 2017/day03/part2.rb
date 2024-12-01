require 'pp'

target = 347991

grid = [[1]]
current_index = [0,0]

direction = 'r'
neighbors = 0
while neighbors < target do
  if direction == 'r'
    current_index[1] += 1
    if grid[current_index[0]][current_index[1]].nil?
      grid.each do |row|
        row.push(0)
      end
      direction = 'u'
    end
  elsif direction == 'u'
    current_index[0] -= 1
    if current_index[0] < 0
      grid.unshift(Array.new(grid[0].length, 0))
      current_index[0] = 0
      direction = 'l'
    end
  elsif direction == 'l'
    current_index[1] -= 1
    if current_index[1] < 0
      grid.each do |row|
        row.unshift(0)
      end
      current_index[1] = 0
      direction = 'd'
    end
  elsif direction == 'd'
    current_index[0] += 1
    if grid[current_index[0]].nil?
      grid.push(Array.new(grid[0].length, 0))
      direction = 'r'
    end
  end
  neighbors = 0
  if current_index[0] > 0
    neighbors += grid[current_index[0]-1][current_index[1]]
    neighbors += grid[current_index[0]-1][current_index[1]-1] if current_index[1] > 0
    neighbors += grid[current_index[0]-1][current_index[1]+1] unless grid[current_index[0]-1][current_index[1]+1].nil?
  end
  unless grid[current_index[0]+1].nil?
    neighbors += grid[current_index[0]+1][current_index[1]]
    neighbors += grid[current_index[0]+1][current_index[1]-1] if current_index[1] > 0
    neighbors += grid[current_index[0]+1][current_index[1]+1] unless grid[current_index[0]+1][current_index[1]+1].nil?
  end
  neighbors += grid[current_index[0]][current_index[1]-1] if current_index[1] > 0
  neighbors += grid[current_index[0]][current_index[1]+1] unless grid[current_index[0]][current_index[1]+1].nil?
  grid[current_index[0]][current_index[1]] = neighbors
end

pp neighbors
