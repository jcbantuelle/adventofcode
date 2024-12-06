require 'pp'

def clone_guard()
  guard = $original_guard.dup
  guard[:mod] = $original_guard[:mod].dup
  guard[:coordinates] = $original_guard[:coordinates].dup
  guard
end

def clone_grid(obstruction=false)
  grid = $original_grid.map{ |row|
    row.map{ |cell|
      cell.nil? ? cell : cell.dup
    }
  }
  grid[obstruction[0]][obstruction[1]] = nil if obstruction
  grid
end

def walk_grid(grid)
  guard = clone_guard()
  looped_guard = false

  loop do
    guard_y = guard[:coordinates][0] + guard[:mod][0]
    guard_x = guard[:coordinates][1] + guard[:mod][1]
    break if guard_y < 0 || guard_y == $max_y || guard_x < 0 || guard_x == $max_x
    if grid[guard_y][guard_x].nil?
      new_direction = $directions[guard[:orientation]]
      guard[:orientation] = new_direction[0]
      guard[:mod] = new_direction[1]
    else
      if grid[guard_y][guard_x][guard[:orientation]]
        looped_guard = true
        break
      end
      grid[guard_y][guard_x][guard[:orientation]] = true
      guard[:coordinates] = [guard_y, guard_x]
    end
  end

  looped_guard
end

$directions = {
  up: [:right, [0,1]],
  right: [:down, [1,0]],
  down: [:left, [0,-1]],
  left: [:up, [-1,0]]
}

$original_guard = {
  orientation: :up,
  mod: [-1,0],
  coordinates: []
}

$original_grid = File.open('input.txt').each_with_index.map{ |row, y|
  row.chomp.split('').each_with_index.map{ |cell, x|
    if cell == '.'
      {
        up: false,
        right: false,
        down: false,
        left: false
      }
    elsif cell == '#'
      nil
    elsif cell == '^'
      $original_guard[:coordinates] = [y,x]
      {
        up: true,
        right: false,
        down: false,
        left: false
      }
    end
  }
}

$max_x = $original_grid[0].length
$max_y = $original_grid.length

grid = clone_grid()
walk_grid(grid)

obstruction_coords = grid.each_with_index.map{ |row, y|
  row.each_with_index.map{ |cell, x|
    cell && [y,x] != $original_guard[:coordinates] && cell.any?{|_,visit| visit} ? [y,x] : nil
  }
}.flatten(1).compact

puts obstruction_coords.reduce(0){ |total, obstruction|
  grid = clone_grid(obstruction)
  total + (walk_grid(grid) ? 1 : 0)
}
