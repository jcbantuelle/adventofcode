require 'pp'

def calc(horizontal, vertical)
  s = symmetry(horizontal)
  if s > 0
    s*100
  else
    symmetry(vertical)
  end
end

def symmetry(grid)
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
      if mirror
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
total += calc(horizontal, vertical)
pp total
