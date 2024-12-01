require 'pp'

$nodes = {}
$seen = {}
$traversals = []

class Node
  attr_accessor :north, :south, :east, :west, :x, :y, :visited, :distance

  def initialize(x, y)
    @x = x
    @y = y
    @visited = false
    @distance = Float::INFINITY
    $nodes[to_index(@x, @y)] = self
  end

  def traverse(directions)
    new_x = x
    new_y = y
    current_node = self
    while directions[0] != '('
      if directions[0] == 'N'
        new_y -= 1
      elsif directions[0] == 'S'
        new_y += 1
      elsif directions[0] == 'W'
        new_x -= 1
      elsif directions[0] == 'E'
        new_x += 1
      end
      new_node = $nodes[to_index(new_x, new_y)] || Node.new(new_x, new_y)
      if directions[0] == 'N'
        new_node.south = current_node
        current_node.north = new_node
      elsif directions[0] == 'S'
        new_node.north = current_node
        current_node.south = new_node
      elsif directions[0] == 'W'
        new_node.east = current_node
        current_node.west = new_node
      elsif directions[0] == 'E'
        new_node.west = current_node
        current_node.east = new_node
      end
      directions = directions[1..-1]
      return if directions.nil? || directions.empty?
      current_node = new_node
    end
    direction_index = 1
    open_paren_count = 1
    close_paren_count = 0
    possibility = ''
    possibilities = []
    while close_paren_count < open_paren_count
      next_direction = directions[direction_index]
      if next_direction == '('
        open_paren_count += 1
        possibility << '('
      elsif next_direction == ')'
        close_paren_count += 1
        possibility << ')' unless close_paren_count == open_paren_count
      elsif next_direction == '|' && open_paren_count == (close_paren_count + 1)
        possibilities << possibility.clone
        possibility = ''
      else
        possibility << next_direction
      end
      direction_index += 1
    end
    possibilities << possibility
    directions_after_possibilities = directions[direction_index..-1]
    $traversals.push(*(possibilities.map{|possibility|
      new_direction = possibility + directions_after_possibilities.clone
      if new_direction.nil? || new_direction.empty?
        nil
      else
        traversal = "#{new_x},#{new_y}/#{new_direction}"
        if $seen[traversal]
          nil
        else
          traversal
        end
      end
    }.compact))
  end

  def walk
    @visited = true
    unless @north.nil? || @north.visited
      @north.distance = @distance + 1
      @north.walk
    end
    unless @south.nil? || @south.visited
      @south.distance = @distance + 1
      @south.walk
    end
    unless @west.nil? || @west.visited
      @west.distance = @distance + 1
      @west.walk
    end
    unless @east.nil? || @east.visited
      @east.distance = @distance + 1
      @east.walk
    end
  end

  def to_index(x_coord, y_coord)
    "#{x_coord},#{y_coord}"
  end
end

start = Node.new(0,0)
$nodes["0,0"] = start
start.traverse(File.open('input.txt').each_line.to_a[0].chomp[1..-2])
while !$traversals.empty?
  traversal = $traversals.shift
  next if $seen[traversal]
  $seen[traversal] = true
  traversal = traversal.split('/')
  $nodes[traversal[0]].traverse(traversal[1])
end

start.distance = 0
start.walk

pp $nodes.select{|_, v|
  v.distance >= 1000
}.length
