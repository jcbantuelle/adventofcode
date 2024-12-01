universe = File.open('input.txt').each_line.map{ |line|
  line.chomp.each_char.map{|c| c == '#' ? true : [1,1]}
}

universe.each_with_index do |row, r|
  universe[r].map!{|r| [1000000,1] } if row.all?{|c| c.is_a?(Array)}
end

0.upto(universe[0].length-1) do |col|
  if universe.map{|r| r[col]}.all?{|c| c.is_a?(Array)}
    universe.each_with_index{|_,row| universe[row][col][1] = 1000000}
  end
end

galaxies = []
universe.each_with_index{ |row, r|
  row.each_with_index{ |cell, c|
    if cell == true
      galaxies << [r,c]
      universe[r][c] = [1,1]
    end
  }
}

puts galaxies.combination(2).inject(0) {|sum, pair|
  row_pair = pair.sort_by{|galaxy| galaxy[0]}
  col_pair = pair.sort_by{|galaxy| galaxy[1]}
  if row_pair[0][0] < row_pair[1][0]
    sum += universe[(row_pair[0][0]+1)..row_pair[1][0]].map{|r| r[row_pair[0][1]][0]}.inject(&:+)
  end
  if col_pair[0][1] < col_pair[1][1]
    sum += universe[col_pair[0][0]][(col_pair[0][1]+1)..col_pair[1][1]].map{|c| c[1]}.inject(&:+)
  end
  sum
}
