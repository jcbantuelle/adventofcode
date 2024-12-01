require 'pp'

cubes = {}
rocks = {}

max = 0
File.open('input.txt').each_line.each_with_index{ |line, row|
  line.chomp.each_char.each_with_index{ |cell, col|
    if cell == '#'
      cubes["#{row},#{col}"] = true
    elsif cell == 'O'
      rocks["#{row},#{col}"] = true
    end
  }
  max = row+1
}

moved = true
while moved
  moved = false
  rocks.keys.sort.each do |rock|
    row, col = rock.split(',').map(&:to_i)
    up_one = "#{row-1},#{col}"
    next if row == 0 || cubes[up_one] || rocks[up_one]
    rocks[up_one] = 1
    rocks.delete(rock)
    moved = true
  end
end

pp rocks.keys.inject(0) {|total, rock|
  row = rock.split(',')[0].to_i
  total + (max - row)
}
