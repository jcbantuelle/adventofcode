require 'pp'

grid = Array.new
101.times do |x|
  grid[x] = Array.new
  101.times do |y|
    grid[x][y] = Array.new(101, 0)
  end
end

File.foreach('input1.txt') do |line|
  instruction = line.chomp.match(/^([a-z]+)\sx=(\-?\d+)\.\.(\-?\d+),y=(\-?\d+)\.\.(\-?\d+),z=(\-?\d+)\.\.(\-?\d+)$/)
  value = instruction[1] == 'on' ? 1 : 0
  x_start = instruction[2].to_i + 50
  x_end = instruction[3].to_i + 50
  y_start = instruction[4].to_i + 50
  y_end = instruction[5].to_i + 50
  z_start = instruction[6].to_i + 50
  z_end = instruction[7].to_i + 50
  x_start.upto(x_end) do |x|
    y_start.upto(y_end) do |y|
      z_start.upto(z_end) do |z|
        grid[x][y][z] = value
      end
    end
  end
end

pp grid.flatten.inject(&:+)
