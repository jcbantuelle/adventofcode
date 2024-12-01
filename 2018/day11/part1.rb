require 'pp'

serial_number = 5468

grid = []
300.times do |col|
  grid[col] = []
  300.times do |row|
    rack_id = row+11
    power_level = ((rack_id * (col+1) + serial_number) * rack_id).to_s[-3] || '0'
    grid[col] << power_level.to_i - 5
  end
end

max = 0
max_coords = nil

grid.each_with_index do |_, y|
  grid.each_with_index do |_, x|
    next if grid[y][x+2].nil? || grid[y+2].nil?
    value = grid[y][x] + grid[y][x+1] + grid[y][x+2] +
            grid[y+1][x] + grid[y+1][x+1] + grid[y+1][x+2] +
            grid[y+2][x] + grid[y+2][x+1] + grid[y+2][x+2]
    if value > max
      max = value
      max_coords = [x+1, y+1]
    end
  end
end

pp "#{max_coords[0]},#{max_coords[1]}"
