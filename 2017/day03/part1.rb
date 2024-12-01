require 'pp'

target = 347991

grid = [[1]]
one_index = [0,0]
current_index = [0,0]

direction = 'r'
2.upto(target) do |next_number|
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
      one_index[0] += 1
      current_index[0] = 0
      direction = 'l'
    end
  elsif direction == 'l'
    current_index[1] -= 1
    if current_index[1] < 0
      grid.each do |row|
        row.unshift(0)
      end
      one_index[1] += 1
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
  grid[current_index[0]][current_index[1]] = next_number
end

pp (one_index[0] - current_index[0]).abs + (one_index[1] - current_index[1]).abs
