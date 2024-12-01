require 'pp'

y_target = 2000000
impossible_locations = {}
beacons_and_sensors = {}
beacons = []

File.open('input.txt').each_line{ |line|
  coords = /[^\d-]*([\d|-]+)[^\d-]*([\d|-]+)[^\d-]*([\d|-]+)[^\d-]*([\d|-]+)/.match(line.chomp)[1..-1].map(&:to_i)
  beacons_and_sensors["#{coords[0]},#{coords[1]}"] = true
  beacons_and_sensors["#{coords[2]},#{coords[3]}"] = true
  beacons << coords
}

beacons.each do |beacon|
  sensor_x = beacon[0].to_i
  sensor_y = beacon[1].to_i
  beacon_x = beacon[2].to_i
  beacon_y = beacon[3].to_i
  max_distance = (sensor_x - beacon_x).abs + (sensor_y - beacon_y).abs
  y_diff = (sensor_y - y_target).abs
  if y_diff <= max_distance
    (sensor_x - max_distance + y_diff).upto(sensor_x + max_distance - y_diff) do |x|
      coords = "#{x},#{y_target}"
      impossible_locations[coords] = true unless beacons_and_sensors[coords]
    end
  end
end

pp impossible_locations.length
