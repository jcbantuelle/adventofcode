require 'pp'

x = 0
y = 0
z = 0

max = 0

File.foreach('input.txt') do |line|
  line.chomp.split(',').each do |direction|
    if direction == 'n'
      x += 1
      y -= 1
    elsif direction == 'ne'
      x += 1
      z -= 1
    elsif direction == 'nw'
      y -= 1
      z += 1
    elsif direction == 's'
      x -= 1
      y += 1
    elsif direction == 'se'
      y += 1
      z -= 1
    elsif direction == 'sw'
      x -= 1
      z += 1
    end
    distance = (x.abs + y.abs + z.abs) / 2
    max = distance if distance > max
  end
end

pp max
