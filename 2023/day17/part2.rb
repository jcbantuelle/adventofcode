require 'pp'

nodes = {}
row = 0
max_row = nil
max_col = nil

File.open('input.txt').each_line{ |line|
  col = 0
  line.chomp.each_char.map{ |loss|
    nodes["#{row},#{col}"] = {
      loss: loss.to_i,
      best: {
        l: [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
        r: [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
        u: [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
        d: [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
      }
    }
    col += 1
  }
  max_col = col - 1
  row += 1
}
max_row = row-1
done = "#{max_row},#{max_col}"

visits = [[0,0,0,nil,0]]
while !visits.empty? do
  row, col, steps, direction, loss = visits.shift

  # Up
  if direction != :d && row > 0 && (direction.nil? || (direction != :u && steps > 3) || (direction == :u && steps < 10))
    coords = "#{row-1},#{col}"
    node = nodes[coords]
    new_direction = :u
    new_steps = direction == :u ? steps + 1 : 1
    new_loss = loss+node[:loss]
    best = node[:best][new_direction][new_steps-1]
    if best.nil? || new_loss < best
      node[:best][new_direction][new_steps-1] = new_loss
      visits << [row-1,col,new_steps,new_direction,new_loss]
    end
  end

  # Down
  if direction != :u && row < max_row && (direction.nil? || (direction != :d && steps > 3) || (direction == :d && steps < 10))
    coords = "#{row+1},#{col}"
    node = nodes[coords]
    new_direction = :d
    new_steps = direction == :d ? steps + 1 : 1
    new_loss = loss+node[:loss]
    best = node[:best][new_direction][new_steps-1]
    if best.nil? || new_loss < best
      if (coords == done && new_steps > 3) || coords != done
        node[:best][new_direction][new_steps-1] = new_loss
        break if coords == done
        visits << [row+1,col,new_steps,new_direction,new_loss]
      end
    end
  end

  # Left
  if direction != :r && col > 0 && (direction.nil? || (direction != :l && steps > 3) || (direction == :l && steps < 10))
    coords = "#{row},#{col-1}"
    node = nodes[coords]
    new_direction = :l
    new_steps = direction == :l ? steps + 1 : 1
    new_loss = loss+node[:loss]
    best = node[:best][new_direction][new_steps-1]
    if best.nil? || new_loss < best
      node[:best][new_direction][new_steps-1] = new_loss
      visits << [row,col-1,new_steps,new_direction,new_loss]
    end
  end

  # Right
  if direction != :l && col < max_col && (direction.nil? || (direction != :r && steps > 3) || (direction == :r && steps < 10))
    coords = "#{row},#{col+1}"
    node = nodes[coords]
    new_direction = :r
    new_steps = direction == :r ? steps + 1 : 1
    new_loss = loss+node[:loss]
    best = node[:best][new_direction][new_steps-1]
    if best.nil? || new_loss < best
      if (coords == done && new_steps > 3) || coords != done
        node[:best][new_direction][new_steps-1] = new_loss
        visits << [row,col+1,new_steps,new_direction,new_loss]
      end
    end
  end

  visits.sort_by!{|visit| visit[4]}
end

pp nodes["#{max_row},#{max_col}"][:best].values.flatten.compact.min
