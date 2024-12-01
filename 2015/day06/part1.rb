require 'pp'

lights = Array.new(1000)
0.upto(1000) do |index|
  lights[index] = Array.new(1000, 0)
end

directions = []

File.foreach('input.txt') do |line|
  direction = line.chomp.match(/(.*)\s(\d*),(\d*)\sthrough\s(\d*),(\d*)/)
  directions.push([direction[1],direction[2].to_i,direction[3].to_i,direction[4].to_i,direction[5].to_i])
end

directions.each do |direction|
  direction[2].upto(direction[4]) do |y_coord|
    direction[1].upto(direction[3]) do |x_coord|
      if direction[0] == 'turn on'
        lights[y_coord][x_coord] = 1
      elsif direction[0] == 'turn off'
        lights[y_coord][x_coord] = 0
      elsif direction[0] == 'toggle'
        lights[y_coord][x_coord] = lights[y_coord][x_coord] == 1 ? 0 : 1
      end
    end
  end
end

pp lights.flatten.select{|light| light == 1}.length
