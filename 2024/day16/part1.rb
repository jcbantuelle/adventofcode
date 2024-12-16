class Move
  ROTATIONS = {
    up: [:left, :right],
    down: [:left, :right],
    left: [:down, :up],
    right: [:down, :up]
  }

  attr_accessor :orientation, :node, :score

  def initialize(orientation, node, score)
    @orientation = orientation
    @node = node
    @score = score
  end

  def move
    continuations = []
    checks = [[@orientation,1]] + ROTATIONS[@orientation].map{|rotation| [rotation, 1001]}
    
    checks.each{ |direction, cost|
      current_node_cost = score + cost - 1
      current_node_score = @node.score[direction]
      next if !current_node_score.nil? && current_node_score < current_node_cost
      @node.score[direction] = current_node_cost
      next_step = @node.send(direction)
      next if next_step.nil?
      if next_step.end_node
        puts @score+cost
        exit
      end
      if next_step.score[direction].nil? || next_step.score[direction] > (score + cost)
        continuations << Move.new(direction, next_step, score+cost)
      end
    }
    continuations
  end

  def to_s
    "Coords: #{@node.coords}, Orientation: #{@orientation}, Score: #{@score}"
  end
end

class Node
  attr_accessor :end_node, :score, :y, :x, :coords, :up, :down, :left, :right

  def initialize(coords, end_node)
    @y, @x = coords
    @coords = coords.join(',')
    @score = {up: nil, down: nil, left: nil, right: nil}
    @end_node = end_node
  end

  def connect!
    [['up', -1, 0], ['down', 1, 0], ['left', 0, -1], ['right', 0, 1]].each{ |direction, y_mod, x_mod|
      connected_node = $nodes["#{@y+y_mod},#{@x+x_mod}"]
      self.send("#{direction}=", connected_node)
    }
  end
end

$nodes = {}
start = nil
File.open('input.txt').each_with_index { |row, y|
  row.chomp.split('').each_with_index { |cell, x|
    next if cell == '#'
    coords = [y,x]
    node = Node.new(coords, cell=='E')
    $nodes[coords.join(',')] = node
    start = node if cell == 'S'
  }
}

$nodes.values.each(&:connect!)
moves = [Move.new(:right, start, 0)]
loop do
  moves.sort_by!(&:score)
  move = moves.shift
  moves += move.move
end
