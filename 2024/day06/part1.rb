directions = {
  up: [:right, [0,1]],
  right: [:down, [1,0]],
  down: [:left, [0,-1]],
  left: [:up, [-1,0]]
}

guard = {
  orientation: :up,
  mod: [-1,0],
  coordinates: [],
  visited: 1
}

grid = File.open('input.txt').each_with_index.map{ |row, y|
  row.chomp.split('').each_with_index.map{|cell, x|
    if cell == '.'
      false
    elsif cell == '#'
      nil
    elsif cell == '^'
      guard[:coordinates] = [y,x]
      true
    end
  }
}

max_x = grid[0].length
max_y = grid.length

loop do
  guard_y = guard[:coordinates][0] + guard[:mod][0]
  guard_x = guard[:coordinates][1] + guard[:mod][1]
  break if guard_y < 0 || guard_y == max_y || guard_x < 0 || guard_x == max_x
  if grid[guard_y][guard_x].nil?
    new_direction = directions[guard[:orientation]]
    guard[:orientation] = new_direction[0]
    guard[:mod] = new_direction[1]
  else
    guard[:visited] += 1 if grid[guard_y][guard_x] == false
    grid[guard_y][guard_x] = true
    guard[:coordinates] = [guard_y, guard_x]
  end
end

puts guard[:visited]
