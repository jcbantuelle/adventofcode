require 'pp'

universe = File.open('input.txt').each_line.map{ |line|
  line.chomp.each_char.map{|c| c == '#' ? true : false}
}

row = 0
while row < universe.length
  if universe[row].all?{|c| c == false}
    universe.insert(row, Array.new(universe[row].length, false))
    row += 2
  else
    row += 1
  end
end

col = 0
while col < universe[0].length
  if universe.map{|r| r[col]}.all?{|c| c == false}
    universe.each{|r| r.insert(col, false)}
    col += 2
  else
    col += 1
  end
end

galaxies = []
universe.each_with_index{ |row, r|
  row.each_with_index{ |cell, c|
    galaxies << [r,c] if cell
  }
}

pp galaxies.combination(2).inject(0) {|sum, pair|
  sum + (pair[0][0] - pair[1][0]).abs + (pair[0][1] - pair[1][1]).abs
}
