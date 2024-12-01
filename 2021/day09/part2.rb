require 'pp'

def basin_size(point)
  if point[1] < 0 || point[0] < 0 || $topography[point[1]].nil? || $topography[point[1]][point[0]].nil? || $topography[point[1]][point[0]] == '.' || $topography[point[1]][point[0]] == 9
    return 0
  else
    $topography[point[1]][point[0]] = '.'
    return 1 + basin_size([point[0]-1,point[1]]) + basin_size([point[0]+1,point[1]]) + basin_size([point[0],point[1]-1]) + basin_size([point[0],point[1]+1])
  end
end

$topography = Array.new

File.foreach('input.txt') do |line|
  $topography.push(line.chomp.each_char.to_a.map(&:to_i))
end

low_points = []

$topography.each_with_index do |row, y_pos|
  row.each_with_index do |point, x_pos|
    top = y_pos == 0 || $topography[y_pos-1][x_pos] > point
    left = x_pos == 0 || $topography[y_pos][x_pos-1] > point
    right = $topography[y_pos][x_pos+1].nil? || $topography[y_pos][x_pos+1] > point
    bottom = $topography[y_pos+1].nil? || $topography[y_pos+1][x_pos] > point
    low_points << [x_pos,y_pos] if top && left && right && bottom
  end
end

basin_sizes = []

low_points.each do |point|
  basin_sizes.push(basin_size(point))
end

pp basin_sizes.sort[-3..-1].inject(&:*)
