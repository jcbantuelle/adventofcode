quadrants = [0,0,0,0]
max_x = 101
max_y = 103
File.open('input.txt').each{ |robot|
  coords = robot.scan(/-?\d+/).map(&:to_i)
  x = (coords[0] + (coords[2]*100)) % max_x
  y = (coords[1] + (coords[3]*100)) % max_y
  if x < (max_x/2) && y < (max_y/2)
    quadrants[0] += 1
  elsif x > (max_x/2) && y < (max_y/2)
    quadrants[1] += 1
  elsif x < (max_x/2) && y > (max_y/2)
    quadrants[2] += 1
  elsif x > (max_x/2) && y > (max_y/2)
    quadrants[3] += 1
  end
}
puts quadrants.inject(&:*)
