require 'pp'

start = Time.now
rows = []
grid_size = 4000000
0.upto(grid_size) do |i|
  rows[i] = []
end

counter = 1
File.open('input.txt').each_line{ |line|
  coords = /[^\d-]*([\d|-]+)[^\d-]*([\d|-]+)[^\d-]*([\d|-]+)[^\d-]*([\d|-]+)/.match(line.chomp)[1..-1].map(&:to_i)
  sensor_x = coords[0].to_i
  sensor_y = coords[1].to_i
  beacon_x = coords[2].to_i
  beacon_y = coords[3].to_i
  max_distance = (sensor_x - beacon_x).abs + (sensor_y - beacon_y).abs

  y_start = sensor_y - max_distance
  y_end = sensor_y + max_distance
  next if y_start > grid_size || y_end < 0
  y_start = 0 if y_start < 0
  y_end = grid_size if y_end > grid_size

  y_start.upto(y_end) do |y|
    y_diff = (sensor_y - y).abs

    x_start = sensor_x - max_distance + y_diff
    x_end = sensor_x + max_distance - y_diff
    next if x_start > grid_size || x_end < 0
    x_start = 0 if x_start < 0
    x_end = grid_size if x_end > grid_size

    rows[y] << [x_start,x_end]
  end
}

rows.each_with_index do |row, y|
  row.sort{|a, b|
    a[0] == b[0] ? a[1] <=> b[1] : a[0] <=> b[0]
  }.inject{|acc, range|
    if acc[0] > 0
      y
      pp "Finished in: #{Time.now - start}s"
      exit
    elsif range[0] > acc[1]
      pp (range[0] - 1) * 4000000 + y
      pp "Finished in: #{Time.now - start}s"
      exit
    else
      [acc[0],[acc[1], range[1]].max]
    end
  }
end
