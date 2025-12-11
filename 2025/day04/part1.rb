grid = File.open('input.txt').reduce([]) { |grid, row|
  grid << row.chomp.chars
}

removable = 0

0.upto(grid.length-1) do |r|
  0.upto(grid[0].length-1) do |c|
    next unless grid[r][c] == '@'
    adjacent_rolls = 0
    (-1..1).each do |r_mod|
      (-1..1).each do |c_mod|
        next if r_mod == 0 && c_mod == 0
        check_r = r + r_mod
        check_c = c + c_mod
        next if check_r == -1 || check_c == -1 || check_r == grid[0].length || check_c == grid.length
        adjacent_rolls += 1 if grid[check_r][check_c] == '@'
      end
    end
    removable += 1 if adjacent_rolls < 4
  end
end

puts removable
