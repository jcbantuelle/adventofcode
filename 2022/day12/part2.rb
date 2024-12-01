require 'pp'

class Node
  attr_accessor :elevation, :end, :x, :y, :visited, :distance

  def initialize(letter, x, y)
    @x = x
    @y = y
    @visited = false
    @distance = Float::INFINITY
    if letter == 'S'
      @elevation = 1
    elsif letter == 'E'
      @elevation = 26
      @end = true
    else
      @elevation = letter.ord - 96
    end
    @distance = 0 if @elevation == 1
  end

  def walk
    @visited = true
    ["#{@x-1},#{@y}", "#{@x+1},#{@y}", "#{@x},#{@y-1}", "#{@x},#{@y+1}"].each do |index|
      node = $nodes[index]
      if node && node.elevation <= @elevation + 1 && node.distance > @distance + 1
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

lines = File.open('input.txt').each_line.map(&:chomp)
$max_x = lines[0].length - 1
$max_y = lines.length - 1
lines.each_with_index { |line, y|
  line.chars.each_with_index{|letter, x|
    node = Node.new(letter, x, y)
    $nodes[node.to_index] = node
  }
}

loop do
  $nodes.values.reject(&:visited).sort_by{|node| node.distance}.first.walk
end
