require 'pp'

y_index = 2946
x_index = 3028

diagonal = 1
count = 1

grid = Array.new(y_index+10000)
(y_index+10000).times do |i|
  grid[i] = Array.new(x_index+10000)
end

x_pos = 0
y_pos = 0
previous_number = 20151125
grid[0][0] = previous_number
loop do
  if diagonal == count
    diagonal += 1
    count = 0
    x_pos = 0
    y_pos = diagonal-1
  end
  number = (previous_number * 252533) % 33554393
  grid[y_pos][x_pos] = number
  break if x_pos == x_index && y_pos == y_index
  count += 1
  x_pos += 1
  y_pos -= 1
  previous_number = number
end

pp grid[y_index][x_index]
