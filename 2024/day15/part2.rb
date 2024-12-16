class Node
  DIRECTIONS = {'^' => :up, 'v' => :down, '<' => :left, '>' => :right}

  attr_accessor :contents, :y, :x, :box_pair, :coords, :up, :down, :left, :right

  def initialize(contents, coords)
    @y, @x = coords
    @coords = coords.join(',')
    @contents = contents
    @box_pair = nil
  end

  def box?
    self.left_box? || self.right_box?
  end

  def left_box?
    @contents == '['
  end

  def right_box?
    @contents == ']'
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
    if self.left_box?
      @box_pair = @right
    elsif self.right_box?
      @box_pair = @left
    else
      @box_pair = nil
    end
  end

  def move(direction, previous)
    if self.empty?
      @contents = previous
    else
      next_node = self.send(DIRECTIONS[direction])
      next_node.move(direction, @contents)
      if (direction == '^' || direction == 'v') && self.box?
        box_node = self.box_pair
        box_next_node = box_node.send(DIRECTIONS[direction])
        box_next_node.move(direction, box_node.contents)
        box_node.contents = '.'
      end
      @contents = previous
    end
  end

  def can_push(direction)
    if self.wall?
      return false
    elsif self.empty?
      return true
    else
      next_nodes = [self.send(DIRECTIONS[direction])]
      if (direction == '^' || direction == 'v') && self.box?
        next_nodes << self.box_pair.send(DIRECTIONS[direction])
      end
      return next_nodes.all?{|node| node.can_push(direction)}
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
    row = []
    line.chomp.split("").each do |cell|
      if cell == '@'
        row += ['@','.']
      elsif cell == 'O'
        row += ['[',']']
      else
        row += [cell, cell]
      end
    end
    grid << row
  end
end

$nodes = {}
grid.each_with_index { |row, y|
  row.each_with_index { |cell, x|
    coords = [y,x]
    $nodes[coords.join(',')] = Node.new(cell, coords)
  }
}

_,robot_node = $nodes.find { |_,node| node.robot? }
moves.each do |direction|
  $nodes.values.each(&:connect!)
  _,robot_node = $nodes.find { |_,node| node.robot? }
  robot_node.move(direction, '.') if robot_node.can_push(direction)
end

puts $nodes.values.select{ |node| node.left_box? }.reduce(0) { |sum, box| sum + (box.y*100) + box.x}
