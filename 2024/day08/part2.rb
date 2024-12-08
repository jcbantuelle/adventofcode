antennae = {}
max = 0

File.open('input.txt').each_with_index{ |row, y|
  max = row.length-2
  row.chomp.split('').each_with_index{ |cell, x|
    unless cell == '.'
      antennae[cell] ||= []
      antennae[cell] << [y,x]
    end
  }
}

antinodes = []
antennae.values.each{ |frequency|
  frequency.combination(2).each{ |f1, f2|
    antinodes << f1
    antinodes << f2

    y_diff = (f1[0] - f2[0]).abs
    x_diff = (f1[1] - f2[1]).abs

    left_sorted = [f1,f2].sort{|a,b|
      a[1] <=> b[1]
    }
    top_sorted = [f1,f2].sort{|a,b|
      a[0] <=> b[0]
    }

    x_mod = top_sorted[0] == left_sorted[0] ? -1 : 1

    top_antinode = top_sorted[0].dup
    loop do
      top_antinode[0] -= y_diff
      top_antinode[1] += (x_diff * x_mod)
      break if top_antinode[0] < 0 || top_antinode[0] > max || top_antinode[1] < 0 || top_antinode[1] > max
      antinodes << top_antinode.dup
    end

    x_mod *= -1
    bottom_antinode = top_sorted[1].dup
    loop do
      bottom_antinode[0] += y_diff
      bottom_antinode[1] += (x_diff * x_mod)
      break if bottom_antinode[0] < 0 || bottom_antinode[0] > max || bottom_antinode[1] < 0 || bottom_antinode[1] > max
      antinodes << bottom_antinode.dup
    end
  }
}

puts antinodes.uniq.length
