require 'pp'

class Node
  attr_reader :x, :y

  def initialize(x,y)
    @x = x
    @y = y
  end

  def to_index
    "#{x},#{y}"
  end

  def <=>(node)
    @y <=> node.y
  end
end

def create_node(x,y)
  unless $nodes["#{x},#{y}"]
    node = Node.new(x,y)
    $nodes[node.to_index] = node
    $x_nodes[x] ||= []
    $x_nodes[x] << node
  end
end

def sort_column(x)
  $x_nodes[x].sort!
end

$nodes = {}
$x_nodes = {}
File.open('input.txt').each_line{ |line|
  segments = line.chomp.split(' -> ')
  0.upto(segments.length-2) do |i|
    x1,y1 = segments[i].split(',').map(&:to_i)
    x2,y2 = segments[i+1].split(',').map(&:to_i)
    if x1 == x2
      if y1 > y2
        y1.downto(y2+1) do |y|
          create_node(x1,y)
        end
      else
        y1.upto(y2-1) do |y|
          create_node(x1,y)
        end
      end
    else
      if x1 > x2
        x1.downto(x2+1) do |x|
          create_node(x,y1)
        end
      else
        x1.upto(x2-1) do |x|
          create_node(x,y1)
        end
      end
    end
  end
  x,y = segments[-1].split(',').map(&:to_i)
  create_node(x,y)
}

$x_nodes.keys.each do |key|
  sort_column(key)
end

settled = 0
loop do
  x = 500
  y = -1
  loop do
    if $x_nodes[x].nil?
      pp settled
      exit
    end
    collision = $x_nodes[x].find{|node| node.y > y}
    if collision.nil?
      pp settled
      exit
    end
    y = collision.y - 1
    if $nodes["#{x-1},#{y+1}"]
      if $nodes["#{x+1},#{y+1}"]
        create_node(x,y)
        sort_column(x)
        settled += 1
        break
      else
        x += 1
        y += 1
      end
    else
      x -= 1
      y += 1
    end
  end
end
