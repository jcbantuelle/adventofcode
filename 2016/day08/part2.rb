require 'pp'

grid = []
6.times do
  grid.push(Array.new(50,0))
end

instructions = []
File.foreach('input.txt') do |line|
  line = line.chomp
  coordinates = nil
  instruction = nil
  if line.include?('rect')
    instruction = 'rect'
    coordinates = line.match(/(\d*)x(\d*)/)
  else
    instruction = line.include?('row') ? 'row' : 'col'
    coordinates = line.match(/(\d*)\sby\s(\d*)/)
  end
  instructions.push([instruction, coordinates[1].to_i, coordinates[2].to_i])
end

instructions.each do |instruction|
  if instruction[0] == 'rect'
    instruction[2].times do |y_pos|
      instruction[1].times do |x_pos|
        grid[y_pos][x_pos] = 1
      end
    end
  elsif instruction[0] == 'row'
    grid[instruction[1]] = grid[instruction[1]][-instruction[2]..grid[0].length] + grid[instruction[1]][0..-(instruction[2]+1)]
  elsif instruction[0] == 'col'
    new_col = grid.map{|row| row[instruction[1]]}
    new_col = new_col[-instruction[2]..new_col.length] + new_col[0..-(instruction[2]+1)]
    new_col.each_with_index do |value, i|
      grid[i][instruction[1]] = value
    end
  end
end

pp grid.map{|row| row.map{|cell| cell == 0 ? '.' : '#'}.join('')}
