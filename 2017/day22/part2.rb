require 'pp'

orientations = ['u', 'r', 'd', 'l']

grid = []

File.foreach('input.txt') do |line|
  grid.push(line.chomp.each_char.to_a)
end

x_pos = (grid[0].count / 2.0).floor
y_pos = (grid.count / 2.0).floor
orientation = 'u'
infections = 0

10000000.times do
  state = grid[y_pos][x_pos]
  if state == '.'
    orientation_index = orientations.find_index(orientation) - 1
    orientation = orientation_index < 0 ? orientations[3] : orientations[orientation_index]
    grid[y_pos][x_pos] = 'w'
  elsif state == 'w'
    grid[y_pos][x_pos] = '#'
    infections += 1
  elsif state == 'f'
    grid[y_pos][x_pos] = '.'
    orientation_index = orientations.find_index(orientation) + 2
    orientation_index -= 4 if orientation_index > 3
    orientation = orientations[orientation_index]
  elsif state == '#'
    orientation_index = orientations.find_index(orientation) + 1
    orientation = orientation_index > 3 ? orientations[0] : orientations[orientation_index]
    grid[y_pos][x_pos] = 'f'
  end
  if orientation == 'u'
    y_pos -= 1
    if y_pos < 0
      grid.unshift(Array.new(grid[0].count, '.'))
      y_pos = 0
    end
  elsif orientation == 'd'
    y_pos += 1
    if y_pos == grid.count
      grid.push(Array.new(grid[0].count, '.'))
    end
  elsif orientation == 'l'
    x_pos -= 1
    if x_pos < 0
      grid.each do |g|
        g.unshift('.')
      end
      x_pos = 0
    end
  elsif orientation == 'r'
    x_pos += 1
    if x_pos == grid[0].count
      grid.each do |g|
        g.push('.')
      end
    end
  end
end

pp infections
