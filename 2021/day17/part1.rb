require 'pp'

def quadratic(c)
  ((-1 + Math.sqrt(1 - (4*c)))/(2.0)).floor
end

x_target = (209..238).to_a
y_target = (-86..-59).to_a

max_y = -1000

x_start_velocity = quadratic(-(2*x_target.min))-2
loop do
  y_start_velocity = 0
  loop do
    max_x = x_start_velocity*(x_start_velocity+1)/2
    x_pos = 0
    y_pos = 0
    x_velocity = x_start_velocity
    y_velocity = y_start_velocity
    max_y_cycle = y_pos
    y_pass_through_target = false
    while x_pos <= x_target.max && y_pos >= y_target.min
      y_pass_through_target = true if y_target.include?(y_pos)
      if x_target.include?(x_pos) && y_target.include?(y_pos)
        max_y = max_y_cycle if max_y_cycle > max_y
        break
      end
      x_pos += x_velocity
      y_pos += y_velocity
      max_y_cycle = y_pos if y_pos > max_y_cycle
      x_mod = x_velocity > 0 ? -1 : 1
      x_velocity += x_mod
      y_velocity -= 1
    end
    break if x_pos > x_target.max || (x_pos == max_x && !y_pass_through_target)
    y_start_velocity += 1
  end
  break if x_start_velocity > x_target.max
  x_start_velocity += 1
end

pp max_y
