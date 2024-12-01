def calc(horizontal, vertical, show=false)
  h_sym = symmetry(horizontal, 0)
  v_sym = symmetry(vertical, 0)
  0.upto(horizontal.length-1) do |i|
    0.upto(horizontal[0].length-1) do |j|
      new_horizontal = horizontal.map(&:clone)
      new_vertical = vertical.map(&:clone)
      replacement = horizontal[i][j] == '.' ? '#' : '.'
      new_horizontal[i][j] = replacement
      new_vertical[j][i] = replacement
      s = symmetry(new_horizontal, h_sym)
      if s > 0
        return s*100
      else
        s = symmetry(new_vertical, v_sym)
        if s > 0
          return s
        end
      end
    end
  end
end

def symmetry(grid, sym)
  0.upto(grid.length-2) do |i|
    if grid[i] == grid[i+1]
      mirror = true
      min = i
      max = grid.length-1-(i+1)
      [min,max].min.times do |j|
        if grid[i-j-1] != grid[i+j+2]
          mirror = false
          break
        end
      end
      if mirror && i+1 != sym
        return i+1
      end
    end
  end
  0
end

horizontal = []
vertical = []
total = File.open('input.txt').each_line.map(&:chomp).inject(0) { |sum, row|
  if row.empty?
    sum += calc(horizontal, vertical)
    horizontal = []
    vertical = []
  else
    horizontal << row
    col = row.each_char.to_a
    if vertical.empty?
      vertical = col
    else
      vertical.each_with_index {|_, i| vertical[i] += col[i]}
    end
  end
  sum
}
total += calc(horizontal, vertical, true)
puts total
