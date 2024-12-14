require 'pp'

max_x = 101
max_y = 103

grid = []
0.upto(max_y) { |y|
  grid[y] = []
  0.upto(max_x) { |x|
    grid[y][x] = '.'
  }
}

robots = File.open('input.txt').map { |robot|
  robot.scan(/-?\d+/).map(&:to_i)
}

v = 68
10000.times{ |second|
  new_grid = grid.map(&:dup)
  robots.each_with_index { |robot, i|
    new_grid[robot[1]][robot[0]] = '#'
    robots[i][0] = (robots[i][0] + robot[2]) % max_x
    robots[i][1] = (robots[i][1] + robot[3]) % max_y
  }
  if second == v
    if second > 2999
      pp "Second #{second}:"
      new_grid.each{|row| pp row.join('')}
      pp ''
      pp '-------------'
      pp ''
    end
    v += 101
  end
}
