class Node
  DIRECTIONS = {'^' => :up, 'v' => :down, '<' => :left, '>' => :right}

  attr_accessor :contents, :y, :x, :coords, :up, :down, :left, :right

  def initialize(contents, coords)
    @y, @x = coords
    @coords = coords.join(',')
    @contents = contents
  end

  def box?
    @contents == 'O'
  end

  def wall?
    @contents == '#'
  end

  def robot?
    @contents == '@'
  end

  def empty?
    @contents == '.'
  end

  def connect!
    [['up', -1, 0], ['down', 1, 0], ['left', 0, -1], ['right', 0, 1]].each{ |direction, y_mod, x_mod|
      connected_node = $nodes["#{@y+y_mod},#{@x+x_mod}"]
      self.send("#{direction}=", connected_node)
    }
  end

  def move(direction, previous=nil)
    if self.wall?
      return false
    elsif self.empty?
      @contents = previous
      return true
    else
      next_node = self.send(DIRECTIONS[direction])
      if next_node.move(direction, @contents)
        if previous.nil?
          @contents = '.'
          return next_node
        else
          @contents = previous
          return true
        end
      else
        if previous.nil?
          return self
        else
          return false
        end
      end
    end
  end
end

grid = []
moves = []
grid_done = false
File.open('input.txt').each do |line|
  if line.chomp.empty?
    grid_done = true
  elsif grid_done
    moves += line.chomp.split("")
  else
    grid << line.chomp.split("")
  end
end

$nodes = {}
grid.each_with_index { |row, y|
  row.each_with_index { |cell, x|
    coords = [y,x]
    $nodes[coords.join(',')] = Node.new(cell, coords)
  }
}
$nodes.values.each(&:connect!)

_,robot_node = $nodes.find { |_,node| node.robot? }
moves.each do |direction|
  robot_node = robot_node.move(direction)
end

puts $nodes.values.select{ |node| node.box? }.reduce(0) { |sum, box| sum + (box.y*100) + box.x}
