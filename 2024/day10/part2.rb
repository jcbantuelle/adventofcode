class Walk
  attr_accessor :node, :visited

  def initialize(node, visited)
    @node = node
    @visited = visited.dup
  end
end

class Node
  attr_accessor :height, :y, :x, :coords, :trailheads, :up, :down, :left, :right

  def initialize(height, coords)
    @height = height
    @y, @x = coords
    @coords = coords.join(',')
    @trailheads = 0
  end

  def connect!
    [['up', -1, 0], ['down', 1, 0], ['left', 0, -1], ['right', 0, 1]].each{ |direction, y_mod, x_mod|
      connected_node = $nodes["#{@y+y_mod},#{@x+x_mod}"]
      self.send("#{direction}=", connected_node)
    }
  end

  def find_trailheads
    traversals = [Walk.new(self, {})]
    loop do
      break if traversals.empty?
      next_walk = traversals.shift
      next_walk.visited[next_walk.node.coords] = true
      if next_walk.node.height == 0
        @trailheads += 1
        next
      end
      traversals += [next_walk.node.up, next_walk.node.down, next_walk.node.left, next_walk.node.right].compact.select{|node|
        !next_walk.visited[node.coords] && node.height == next_walk.node.height - 1
      }.map{|node| Walk.new(node, next_walk.visited)}
    end
  end
end

$nodes = {}
File.open('input.txt').each_with_index { |row, y|
  row.chomp.split('').each_with_index { |cell, x|
    coords = [y,x]
    $nodes[coords.join(',')] = Node.new(cell.to_i, coords)
  }
}

$nodes.values.each(&:connect!)
nines = $nodes.values.select{|node| node.height == 9}
nines.each(&:find_trailheads)
puts nines.map(&:trailheads).reduce(&:+)
