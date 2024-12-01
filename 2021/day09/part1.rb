require 'pp'

topography = Array.new

File.foreach('input.txt') do |line|
  topography.push(line.chomp.each_char.to_a.map(&:to_i))
end

risk = 0

topography.each_with_index do |row, y_pos|
  row.each_with_index do |point, x_pos|
    top = y_pos == 0 || topography[y_pos-1][x_pos] > point
    left = x_pos == 0 || topography[y_pos][x_pos-1] > point
    right = topography[y_pos][x_pos+1].nil? || topography[y_pos][x_pos+1] > point
    bottom = topography[y_pos+1].nil? || topography[y_pos+1][x_pos] > point
    risk += (point + 1) if top && left && right && bottom
  end
end

pp risk
