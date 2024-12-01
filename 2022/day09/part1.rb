require 'pp'

head_coords = [0,0]
tail_coords = [0,0]

tail_tracker = {'0,0' => true}

File.open('input.txt').each_line{ |line|
  direction, steps = line.chomp.split
  steps = steps.to_i
  x_mod = 0
  y_mod = 0
  y_mod = -1 if direction == 'U'
  y_mod = 1 if direction == 'D'
  x_mod = -1 if direction == 'L'
  x_mod = 1 if direction == 'R'
  steps.times do
    head_coords[0] += x_mod
    head_coords[1] += y_mod
    x_diff = tail_coords[0] - head_coords[0]
    y_diff = tail_coords[1] - head_coords[1]
    if (x_diff.abs > 1 && y_diff != 0) || (y_diff.abs > 1 && x_diff != 0)
      tail_coords[0] = head_coords[0] - x_mod
      tail_coords[1] = head_coords[1] - y_mod
    elsif x_diff.abs > 1
      tail_coords[0] += (x_diff < 0 ? 1 : -1)
    elsif y_diff.abs > 1
      tail_coords[1] += (y_diff < 0 ? 1 : -1)
    end
    tail_tracker["#{tail_coords.join(',')}"] = true
  end
}

pp tail_tracker.length
