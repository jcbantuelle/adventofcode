cubes = {}
rocks = {}
seen = {}

def serialize(rocks)
  rocks.keys.sort.join('-')
end

max_row = 0
max_col = 0
File.open('input.txt').each_line.map(&:chomp).each_with_index{ |line, row|
  max_col = line.length
  line.each_char.each_with_index{ |cell, col|
    if cell == '#'
      cubes["#{row},#{col}"] = true
    elsif cell == 'O'
      rocks["#{row},#{col}"] = true
    end
  }
  max_row = row+1
}

# Cycle until seen
iteration = 0
while !seen[serialize(rocks)]
  seen[serialize(rocks)] = iteration
  iteration += 1

  # North
  moved = true
  while moved
    moved = false
    rocks.keys.sort.each do |rock|
      row, col = rock.split(',').map(&:to_i)
      up_one = "#{row-1},#{col}"
      next if row == 0 || cubes[up_one] || rocks[up_one]
      rocks[up_one] = true
      rocks.delete(rock)
      moved = true
    end
  end

  # West
  moved = true
  while moved
    moved = false
    rocks.keys.sort.each do |rock|
      row, col = rock.split(',').map(&:to_i)
      left_one = "#{row},#{col-1}"
      next if col == 0 || cubes[left_one] || rocks[left_one]
      rocks[left_one] = true
      rocks.delete(rock)
      moved = true
    end
  end

  # South
  moved = true
  while moved
    moved = false
    rocks.keys.sort.each do |rock|
      row, col = rock.split(',').map(&:to_i)
      down_one = "#{row+1},#{col}"
      next if row == max_row-1 || cubes[down_one] || rocks[down_one]
      rocks[down_one] = true
      rocks.delete(rock)
      moved = true
    end
  end

  # East
  moved = true
  while moved
    moved = false
    rocks.keys.sort.each do |rock|
      row, col = rock.split(',').map(&:to_i)
      right_one = "#{row},#{col+1}"
      next if col == max_col-1 || cubes[right_one] || rocks[right_one]
      rocks[right_one] = true
      rocks.delete(rock)
      moved = true
    end
  end
end

cycle = iteration - seen[serialize(rocks)]
state = (1000000000-iteration) % cycle
position = seen[serialize(rocks)] + state
puts seen.key(position).split('-').inject(0) {|total, rock|
  row = rock.split(',')[0].to_i
  total + (max_row - row)
}
