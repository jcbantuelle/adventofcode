grid = File.open('input.txt').map { |line| line.chomp.split('') }
puts 0.upto(grid[0].length-1).reduce(0){ |sum, x|
  sum + 0.upto(grid.length-1).reduce(0){ |y_sum, y|
    y_sum + [[-1,-1],[0,-1],[1,-1],[-1,0],[1,0],[-1,1],[0,1],[1,1]].reduce(0) { |mod_sum, mod|
      x_coord = x
      y_coord = y
      word = grid[x][y]
      3.times{
        x_coord += mod[0]
        y_coord += mod[1]
        word += grid[x_coord][y_coord] unless x_coord < 0 || y_coord < 0 || x_coord > grid[0].length-1 || y_coord > grid.length-1
      }
      mod_sum + (word == 'XMAS' ? 1 : 0)
    }
  }
}
