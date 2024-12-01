require 'pp'

grid = File.open('input.txt').each_line.map{ |line|
  line.chomp.each_char.map{|char|
    {
      value: char,
      energized: false,
      seen: {
        'u': false,
        'd': false,
        'l': false,
        'r': false
      }
    }
  }
}

max_row = grid.length-1
max_col = grid[0].length - 1

lasers = [[0,3,'d']]
while !lasers.empty?
  row, col, dir = lasers.shift
  new_lasers = [[row, col, dir]]
  grid[row][col][:energized] = true
  grid[row][col][:seen][dir] = true
  case grid[row][col][:value]
  when '/'
    case dir
    when 'l'
      new_lasers[0][2] = 'd'
    when 'r'
      new_lasers[0][2] = 'u'
    when 'u'
      new_lasers[0][2] = 'r'
    when 'd'
      new_lasers[0][2] = 'l'
    end
  when '\\'
    case dir
    when 'l'
      new_lasers[0][2] = 'u'
    when 'r'
      new_lasers[0][2] = 'd'
    when 'u'
      new_lasers[0][2] = 'l'
    when 'd'
      new_lasers[0][2] = 'r'
    end
  when '|'
    if ['l','r'].include?(dir)
      new_lasers[0][2] = 'u'
      new_lasers[1] = new_lasers[0].clone
      new_lasers[1][2] = 'd'
    end
  when '-'
    if ['u','d'].include?(dir)
      new_lasers[0][2] = 'l'
      new_lasers[1] = new_lasers[0].clone
      new_lasers[1][2] = 'r'
    end
  end
  lasers += new_lasers.map{|laser|
    case laser[2]
    when 'l'
      laser[1] -= 1
    when 'r'
      laser[1] += 1
    when 'u'
      laser[0] -= 1
    when 'd'
      laser[0] += 1
    end
    laser
  }.reject{|laser|
    r = laser[0]
    c = laser[1]
    d = laser[2]
    r < 0 || c < 0 || r > max_row || c > max_col || grid[r][c][:seen][d]
  }
end

pp grid.flatten.select{|c| c[:energized]}.length
