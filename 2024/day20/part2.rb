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
      next_score = @score + 1
      if next_step.end_node
        next_step.score = next_score
      elsif next_step.score.nil? || next_step.score > next_score
        next_step.score = next_score
        continuations << next_step
      end
    }
    continuations
  end
end

$nodes = {}
start_node = nil
end_node = nil
File.open('input.txt').each_with_index { |row, y|
  row.chomp.split('').each_with_index { |cell, x|
    next if cell == '#'
    coords = [y,x]
    node = Node.new(coords, cell=='E')
    $nodes[coords.join(',')] = node
    start_node = node if cell == 'S'
    end_node = node if cell == 'E'
  }
}
$nodes.values.each(&:connect!)

start_node.score = 0
moves = [start_node]
loop do
  break if moves.empty?
  moves.sort_by!(&:score)
  move = moves.shift
  moves += move.move
end

cheats = 0

coord_mods = []
20.downto(0) { |y|
  (20-y).downto(0) { |x|
    coord_mods += [[y,x],[-y,x],[y,-x],[-y,-x]].uniq
  }
}

$nodes.values.each do |node|
  coord_mods.each { |y_cheat, x_cheat|
    distance = y_cheat.abs + x_cheat.abs
    destination_coords = "#{node.y+y_cheat},#{node.x+x_cheat}"
    destination = $nodes[destination_coords]
    if !destination.nil? && destination.score > node.score
      saved = destination.score - node.score - distance
      cheats += 1 if saved >= 100
    end
  }
end
puts cheats
