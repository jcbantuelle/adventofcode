require 'pp'

def quadratic(c)
  ((-1 + Math.sqrt(1 - (4*c)))/(2.0)).floor
end

x_target = (209..238).to_a
y_target = (-86..-59).to_a

valid_targets = []

x_start_velocity = quadratic(-(2*x_target.min))-5
loop do
  y_start_velocity = y_target.min
  loop do
    max_x = x_start_velocity*(x_start_velocity+1)/2
    x_pos = 0
    y_pos = 0
    x_velocity = x_start_velocity
    y_velocity = y_start_velocity
    y_miss_target = 0
    while x_pos <= x_target.max && y_pos >= y_target.min
      y_miss_target += 1 if x_pos == max_x
      if x_target.include?(x_pos) && y_target.include?(y_pos)
        valid_targets << [x_start_velocity, y_start_velocity]
        break
      end
      x_pos += x_velocity
      y_pos += y_velocity
      if x_velocity > 0
        x_mod = -1
      elsif x_velocity < 0
        x_mod = 1
      else
        x_mod = 0
      end
      x_velocity += x_mod
      y_velocity -= 1
    end
    break if x_pos > x_target.max || (x_pos == max_x && y_miss_target > 155)
    y_start_velocity += 1
  end
  break if x_start_velocity > x_target.max
  x_start_velocity += 1
end

pp valid_targets.length
