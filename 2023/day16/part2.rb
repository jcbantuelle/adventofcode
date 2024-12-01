require 'pp'

original_grid = File.open('input.txt').each_line.map{ |line|
  line.chomp.each_char.to_a
}

max = original_grid.length-1

starts = []
0.upto(max) do |i|
  starts << [0,i,'d']
  starts << [max,i,'u']
  starts << [i,0,'r']
  starts << [i,max,'l']
end

max_energy = 0
starts.each do |l|
  grid = original_grid.map{|r|
    r.map{|c|
      {
        value: c,
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
  lasers = [l]
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
      r < 0 || c < 0 || r > max || c > max || grid[r][c][:seen][d]
    }
  end
  energy = grid.flatten.select{|c| c[:energized]}.length
  max_energy = energy if energy > max_energy
end

pp max_energy
