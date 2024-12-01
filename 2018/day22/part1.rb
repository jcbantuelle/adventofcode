require 'pp'

depth = 11541
target_x = 14
target_y = 778

regions = []

total_risk = 0
0.upto(target_y) do |y|
  regions[y] = []
  0.upto(target_x) do |x|
    geologic_index = nil
    if (x == 0 && y == 0) || (x == target_x && y == target_y)
      geologic_index = 0
    elsif x == 0
      geologic_index = y * 48271
    elsif y == 0
      geologic_index = x * 16807
    else
      geologic_index = regions[y][x-1] * regions[y-1][x]
    end
    regions[y][x] = (geologic_index + depth) % 20183
    total_risk += regions[y][x] % 3
  end
end

pp total_risk
