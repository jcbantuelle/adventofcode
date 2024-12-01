require 'pp'

matrix = Array.new
IO.readlines('input.txt').each do |line|
  matrix.push(line.chomp.each_char.to_a.map(&:to_i))
end

max_row = max_col = matrix.size - 1
matrix[0][0] = 0

max_row.downto(0) do |row|
  max_col.downto(0) do |col|
    if row == max_row && col == max_col
      min = 0
    elsif col == max_col
      min = matrix[row+1][col]
    elsif row == max_row
      min = matrix[row][col+1]
    else
      min = [matrix[row+1][col], matrix[row][col+1]].min
    end
    matrix[row][col] += min
  end
end

puts matrix[0][0]
