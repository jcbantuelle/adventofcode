require 'pp'

class Node
  attr_accessor :elevation, :start, :end, :x, :y, :visited, :distance

  def initialize(letter, x, y)
    @x = x
    @y = y
    @visited = false
    @distance = Float::INFINITY
    if letter == 'S'
      @elevation = 1
      @start = true
      @distance = 0
    elsif letter == 'E'
      @elevation = 26
      @end = true
    else
      @elevation = letter.ord - 96
    end
  end

  def walk
    @visited = true
    # Left
    if @x > 0
      node = $nodes["#{@x-1},#{@y}"]
      if node.elevation <= @elevation + 1 && node.distance > @distance + 1
        node.distance = @distance + 1
        if node.end
          pp node.distance
          exit
        end
      end
    end
    # Right
    if @x < $max_x
      node = $nodes["#{@x+1},#{@y}"]
      if node.elevation <= @elevation + 1 && node.distance > @distance + 1
        node.distance = @distance + 1
        if node.end
          pp node.distance
          exit
        end
      end
    end
    # Up
    if @y > 0
      node = $nodes["#{@x},#{@y-1}"]
      if node.elevation <= @elevation + 1 && node.distance > @distance + 1
        node.distance = @distance + 1
        if node.end
          pp node.distance
          exit
        end
      end
    end
    # Down
    if @y < $max_y
      node = $nodes["#{@x},#{@y+1}"]
      if node.elevation <= @elevation + 1 && node.distance > @distance + 1
        node.distance = @distance + 1
        if node.end
          pp node.distance
          exit
        end
      end
    end
  end

  def to_index
    "#{x},#{y}"
  end
end

$nodes = {}
start = nil

lines = File.open('input.txt').each_line.map(&:chomp)
$max_x = lines[0].length - 1
$max_y = lines.length - 1
lines.each_with_index { |line, y|
  line.chars.each_with_index{|letter, x|
    node = Node.new(letter, x, y)
    start = node if node.start
    $nodes[node.to_index] = node
  }
}

start.walk
loop do
  $nodes.values.reject(&:visited).sort_by{|node| node.distance}.first.walk
end
