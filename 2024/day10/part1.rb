class Node
  attr_accessor :height, :y, :x, :coords, :visited, :trailheads, :up, :down, :left, :right

  def initialize(height, coords)
    @height = height
    @y, @x = coords
    @coords = coords.join(',')
    @visited = {}
    @trailheads = 0
  end

  def connect!
    [['up', -1, 0], ['down', 1, 0], ['left', 0, -1], ['right', 0, 1]].each{ |direction, y_mod, x_mod|
      connected_node = $nodes["#{@y+y_mod},#{@x+x_mod}"]
      self.send("#{direction}=", connected_node)
    }
  end

  def find_trailheads
    traversals = [self]
    loop do
      break if traversals.empty?
      next_node = traversals.shift
      @visited[next_node.coords] = true
      if next_node.height == 0
        @trailheads += 1
        next
      end
      traversals += [next_node.up, next_node.down, next_node.left, next_node.right].compact.select{|node|
        !@visited[node.coords] && node.height == next_node.height - 1
      }
      traversals.uniq!
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
