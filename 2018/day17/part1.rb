require 'pp'

clay = []
min_x = nil
max_x = nil
min_y = nil
max_y = nil

File.foreach('input.txt') do |line|
  clay_segment = line.chomp.split(', ')

  first = clay_segment[0].split('=')
  first[1] = first[1].to_i
  second = clay_segment[1].split('=')[1].split('..').map(&:to_i)

  clay << [first, second]

  if first[0] == 'x'
    min_x = first[1] if min_x.nil? || first[1] < min_x
    max_x = first[1] if max_x.nil? || first[1] > max_x
    min_y = second[0] if min_y.nil? || second[0] < min_y
    max_y = second[1] if max_y.nil? || second[1] > max_y
  else
    min_y = first[1] if min_y.nil? || first[1] < min_y
    max_y = first[1] if max_y.nil? || first[1] > max_y
    min_x = second[0] if min_x.nil? || second[0] < min_x
    max_x = second[1] if max_x.nil? || second[1] > max_x
  end
end

grid = []
min_y.upto(max_y) do |y|
  row = []
  (min_x-1).upto(max_x+1) do |x|
    row << '.'
  end
  grid << row
end

max_x -= (min_x - 2)

clay.each do |clay_segment|
  if clay_segment[0][0] == 'x'
    x = clay_segment[0][1] - min_x + 1
    clay_segment[1][0].upto(clay_segment[1][1]) do |y|
      grid[y-min_y][x] = '#'
    end
  else
    y = clay_segment[0][1] - min_y
    clay_segment[1][0].upto(clay_segment[1][1]) do |x|
      grid[y][x-min_x+1] = '#'
    end
  end
end

fills = [[500 - min_x + 1, 0]]
already_filled = {}

while fills.length > 0 do
  current_x, current_y = fills.pop
  if grid[current_y+1]
    next_tile = grid[current_y+1][current_x]
    if next_tile == '~' || next_tile == '#'
      left_clay = nil
      (current_x-1).downto(0) do |x|
        if grid[current_y][x] == '#'
          left_clay = x+1
          break
        elsif %w(. |).include?(grid[current_y+1][x])
          break
        end
      end
      right_clay = nil
      (current_x+1).upto(max_x) do |x|
        if grid[current_y][x] == '#'
          right_clay = x-1
          break
        elsif %w(. |).include?(grid[current_y+1][x])
          break
        end
      end
      if left_clay && right_clay
        left_clay.upto(right_clay) do |x|
          grid[current_y][x] = '~'
        end
        fill_index = "#{current_x},#{current_y-1}"
        fills.push([current_x, current_y-1])
        already_filled[fill_index] = true
      else
        if left_clay
          right_stop = nil
          (current_x+1).upto(max_x) do |x|
            if %w(. |).include?(grid[current_y+1][x])
              right_stop = x
              break
            end
          end
          left_clay.upto(right_stop) do |x|
            grid[current_y][x] = '|'
          end
          fill_index = "#{right_stop},#{current_y+1}"
          if already_filled[fill_index].nil?
            fills.push([right_stop, current_y+1])
            already_filled[fill_index] = true
          end
        elsif right_clay
          left_stop = nil
          (current_x-1).downto(0) do |x|
            if %w(. |).include?(grid[current_y+1][x])
              left_stop = x
              break
            end
          end
          left_stop.upto(right_clay) do |x|
            grid[current_y][x] = '|'
          end
          fill_index = "#{left_stop},#{current_y+1}"
          if already_filled[fill_index].nil?
            fills.push([left_stop, current_y+1])
            already_filled[fill_index] = true
          end
        else
          left_stop = nil
          (current_x-1).downto(0) do |x|
            if %w(. |).include?(grid[current_y+1][x])
              left_stop = x
              break
            end
          end
          right_stop = nil
          (current_x+1).upto(max_x) do |x|
            if %w(. |).include?(grid[current_y+1][x])
              right_stop = x
              break
            end
          end
          left_stop.upto(right_stop) do |x|
            grid[current_y][x] = '|'
          end

          fill_index = "#{left_stop},#{current_y+1}"
          if already_filled[fill_index].nil?
            fills.push([left_stop, current_y+1])
            already_filled[fill_index] = true
          end

          fill_index = "#{right_stop},#{current_y+1}"
          if already_filled[fill_index].nil?
            fills.push([right_stop, current_y+1])
            already_filled[fill_index] = true
          end
        end
      end
    else
      grid[current_y][current_x] = '|'
      fills.push([current_x, current_y+1])
    end
  else
    grid[current_y][current_x] = '|'
  end
end

pp grid.map{|row| row.select{|cell| cell == '|' || cell == '~'}}.flatten.length
