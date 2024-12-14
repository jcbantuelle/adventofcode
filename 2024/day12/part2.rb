class Node
  attr_accessor :id, :plant, :y, :x, :coords, :up, :down, :left, :right

  def initialize(plant, coords)
    @y, @x = coords
    @coords = coords.join(',')
    @plant = plant
    @up = nil
    @down = nil
    @left = nil
    @right = nil
  end

  def connect!(id)
    @id = id

    [['up', -1, 0], ['down', 1, 0], ['left', 0, -1], ['right', 0, 1]].each{ |direction, y_mod, x_mod|
      connected_node = $nodes["#{@y+y_mod},#{@x+x_mod}"]
      connected_node = nil if !connected_node.nil? && connected_node.plant != @plant
      unless connected_node.nil?
        self.send("#{direction}=", connected_node)
        connected_node.connect!(@id) if connected_node.id.nil?
      end
    }
  end
end

def sides(stretch)
  sides = 0
  last_node = -5
  stretch.sort! 
  loop do
    break if stretch.empty?
    node = stretch.shift
    sides += 1 if node-1 != last_node
    last_node = node
  end
  sides
end

$nodes = {}
File.open('input.txt').each_with_index { |row, y|
  row.chomp.split('').each_with_index { |plant, x|
    coords = [y,x]
    $nodes[coords.join(',')] = Node.new(plant, coords)
  }
}

require 'pp'
next_id = 0
loop do
  next_node = $nodes.values.find{|node| node.id.nil?}
  break if next_node.nil?
  next_node.connect!(next_id)
  next_id += 1
end

pp (0..next_id-1).reduce(0) { |cost, id|
  region = $nodes.values.select{|node| node.id == id}
  ups = {}
  downs = {}
  lefts = {}
  rights = {}
  region.each{|node|
    if node.up.nil?
      ups[node.y] ||= []
      ups[node.y] << node.x
    end
    if node.down.nil?
      downs[node.y] ||= []
      downs[node.y] << node.x
    end
    if node.left.nil?
      lefts[node.x] ||= []
      lefts[node.x] << node.y
    end
    if node.right.nil?
      rights[node.x] ||= []
      rights[node.x] << node.y
    end
  }
  sides = 0
  sides += ups.values.reduce(0) {|sum, stretch|
    sum + sides(stretch)
  }
  sides += downs.values.reduce(0) {|sum, stretch|
    sum + sides(stretch)
  }
  sides += lefts.values.reduce(0) {|sum, stretch|
    sum + sides(stretch)
  }
  sides += rights.values.reduce(0) {|sum, stretch|
    sum + sides(stretch)
  }

  cost + (sides * region.length)
}
