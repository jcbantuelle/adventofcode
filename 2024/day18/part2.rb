class Node
  attr_accessor :end_node, :score, :y, :x, :coords, :up, :down, :left, :right

  def initialize(coords, end_node)
    @y, @x = coords
    @coords = coords.join(',')
    @score = nil
    @end_node = end_node
  end

  def connect!
    [['up', -1, 0], ['down', 1, 0], ['left', 0, -1], ['right', 0, 1]].each{ |direction, y_mod, x_mod|
      connected_node = $nodes["#{@y+y_mod},#{@x+x_mod}"]
      self.send("#{direction}=", connected_node)
    }
  end

  def move
    continuations = []

    [:up, :down, :left, :right].each{ |direction|
      next_step = self.send(direction)
      next if next_step.nil?
      if next_step.end_node
        return nil
      end
      if next_step.score.nil? || next_step.score > (@score + 1)
        next_step.score = @score+1
        continuations << next_step
      end
    }
    continuations
  end
end

$nodes = {}
start = nil
grid_size = 70
0.upto(grid_size) { |y|
  0.upto(grid_size) { |x|
    coords = [y,x]
    node = Node.new(coords, coords == [grid_size,grid_size])
    $nodes[coords.join(',')] = node
    start = node if coords == [0,0]
  }
}

additional_bytes = []
File.open('input.txt').each_with_index { |coords, i|
  x,y = coords.chomp.split(',')
  if i <= 1023
    $nodes.delete("#{y},#{x}")
  else
    additional_bytes << "#{y},#{x}"
  end
}
$nodes.values.each(&:connect!)

additional_bytes.each do |byte|
  $nodes.delete(byte)
  $nodes.values.each{|node| node.score = nil}
  start.score = 0
  moves = [start]
  loop do
    if moves.empty?
      y,x = byte.split(',')
      puts "#{x},#{y}"
      exit
    end
    moves.sort_by!(&:score)
    move = moves.shift
    next_moves = move.move
    break if next_moves.nil?
    moves += next_moves
  end
end
