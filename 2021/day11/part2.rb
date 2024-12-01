require 'pp'

octopi = []

File.foreach('input.txt') do |line|
  octopuses = line.chomp.each_char.to_a.map{ | octopus|
    {
      value: octopus.to_i,
      flashed: false
    }
  }
  octopi.push(octopuses)
end

flashes = 0
flash_count = 0
step_count = 0

while flash_count < 100 do
  step_count += 1
  flash_count = 0
  octopi.each do |row|
    row.each do |octopus|
      octopus[:value] += 1
    end
  end
  while !octopi.flatten.select{|octopus| octopus[:value] > 9 && octopus[:flashed] == false}.empty? do
    octopi.each_with_index do |row, y_index|
      row.each_with_index do |octopus, x_index|
        if octopus[:value] > 9 && octopus[:flashed] == false
          flashes += 1
          octopus[:flashed] = true
          -1.upto(1) do |y_mod|
            -1.upto(1) do |x_mod|
              next if x_mod == 0 && y_mod == 0
              y_coord = y_index + y_mod
              x_coord = x_index + x_mod
              if y_coord >= 0 && !octopi[y_coord].nil? && x_coord >= 0 && !octopi[y_coord][x_coord].nil?
                octopi[y_coord][x_coord][:value] += 1
              end
            end
          end
        end
      end
    end
  end
  octopi.each do |row|
    row.each do |octopus|
      if octopus[:flashed] == true
        octopus[:flashed] = false
        octopus[:value] = 0
        flash_count += 1
      end
    end
  end
end

pp step_count
