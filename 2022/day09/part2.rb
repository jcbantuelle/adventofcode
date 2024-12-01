require 'pp'

knot_coords = [
  [0,0],
  [0,0],
  [0,0],
  [0,0],
  [0,0],
  [0,0],
  [0,0],
  [0,0],
  [0,0],
  [0,0]
]

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
    knot_coords[0][0] += x_mod
    knot_coords[0][1] += y_mod
    1.upto(9) do |knot|
      x_diff = knot_coords[knot][0] - knot_coords[knot-1][0]
      if x_diff.abs > 1
        if x_diff < 0
          knot_coords[knot][0] += 1
        else
          knot_coords[knot][0] -= 1
        end
        if knot_coords[knot][1] != knot_coords[knot-1][1]
          if knot_coords[knot][1] > knot_coords[knot-1][1]
            knot_coords[knot][1] -= 1
          else
            knot_coords[knot][1] += 1
          end
        end
      end
      y_diff = knot_coords[knot][1] - knot_coords[knot-1][1]
      if y_diff.abs > 1
        if y_diff < 0
          knot_coords[knot][1] += 1
        else
          knot_coords[knot][1] -= 1
        end
        if knot_coords[knot][0] != knot_coords[knot-1][0]
          if knot_coords[knot][0] > knot_coords[knot-1][0]
            knot_coords[knot][0] -= 1
          else
            knot_coords[knot][0] += 1
          end
        end
      end
    end
    tail_tracker["#{knot_coords[9].join(',')}"] = true
  end
}

pp tail_tracker.length
