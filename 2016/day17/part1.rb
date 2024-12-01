require 'pp'
require 'digest'

class Node
  attr_accessor :path, :x, :y

  def initialize(path, x, y)
    @path = path
    @x = x
    @y = y
  end

  def process
    doors.each { |letter, index|
      next unless %w{b c d e f}.include?(letter)
      node = nil
      if index == 0 && y > 0
        node = Node.new("#{path}U", x, y-1)
      elsif index == 1 && y < 3
        node = Node.new("#{path}D", x, y+1)
      elsif index == 2 && x > 0
        node = Node.new("#{path}L", x-1, y)
      elsif index == 3 && x < 3
        node = Node.new("#{path}R", x+1, y)
      end
      if node
        if node.x == 3 && node.y == 3
          pp Time.now - $start
          pp node.path
          exit
        else
          insertion_index = $unvisited_nodes.find_index{|unvisited|
            unvisited_length = unvisited.path.length
            node_length = node.path.length
            if unvisited_length == node_length
              unvisited.distance >= node.distance
            else
              unvisited_length >= node_length
            end
          }
          insertion_index = -1 if insertion_index.nil?
          $unvisited_nodes.insert(insertion_index, node)
        end
      end
    }
  end

  def distance
    (3-x) + (3-y)
  end

  def doors
    Digest::MD5.hexdigest("#{$passcode}#{path}")[0..3].each_char.to_a.each_with_index
  end
end

$passcode = 'pxxbnzuo'
node = Node.new('', 0, 0)
$unvisited_nodes = [node]

$start = Time.now
loop do
  next_node = $unvisited_nodes.shift
  next_node.process
end
