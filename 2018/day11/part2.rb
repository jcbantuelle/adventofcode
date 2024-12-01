require 'pp'

serial_number = 5468

grid = []
300.times do |col|
  grid[col] = []
  300.times do |row|
    rack_id = row+11
    power_level = ((rack_id * (col+1) + serial_number) * rack_id).to_s[-3] || '0'
    grid[col] << [power_level.to_i - 5, 0]
  end
end

max = 0
max_coords = nil

1.upto(300) do |size|
  grid.each_with_index do |_, y|
    break if grid[y+size-1].nil?
    grid.each_with_index do |_, x|
      break if grid[y][x+size-1].nil?
      value = grid[y][x][1]
      y.upto(y+size-2) do |y_mod|
        value += grid[y_mod][x+size-1][0]
      end
      x.upto(x+size-1) do |x_mod|
        value += grid[y+size-1][x_mod][0]
      end
      if value > max
        max = value
        max_coords = [x+1, y+1, size]
      end
      grid[y][x][1] = value
    end
  end
end

pp "#{max_coords[0]},#{max_coords[1]},#{max_coords[2]}"
