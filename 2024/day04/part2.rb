grid = File.open('input.txt').map { |line| line.chomp.split('') }
puts 1.upto(grid.length-2).reduce(0){ |sum, y|
  sum + 1.upto(grid[0].length-2).reduce(0){ |x_sum, x|
    mas1 = grid[y-1][x-1] + grid[y][x] + grid[y+1][x+1]
    mas2 = grid[y-1][x+1] + grid[y][x] + grid[y+1][x-1]
    xmas = (mas1 == "MAS" || mas1.reverse == "MAS") && (mas2 == "MAS" || mas2.reverse == "MAS") ? 1 : 0
    x_sum + xmas
  }
}
