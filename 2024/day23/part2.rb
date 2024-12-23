require 'pp'

class Node
  attr_accessor :id, :connections

  def initialize(id)
    @id = id
    @connections = {}
  end

  def add_connection(node)
    @connections[node.id] = node
  end

  def largest
    @connections.values.each { |node|
      connected_ids = [[node.id, @id].sort]
      loop do
        new_connected_ids = []
        connected_ids.each { |connection|
          connection_string = connection.join(',')
          if $viewed_connections[connection_string].nil?
            $viewed_connections[connection_string] = true
            overlap = connection.map{|node_id| $nodes[node_id].connections.keys}.inject(&:&)
            overlap.each { |o|
              new_connected_ids << (connection + [o]).sort
            }
          end
        }
        break if new_connected_ids.empty?
        connected_ids = new_connected_ids
      end
      if connected_ids[0].length > $largest
        $largest = connected_ids[0].length
        $largest_seq = connected_ids[0].sort
      end
    }
  end
end

$viewed_connections = {}
$nodes = {}
$largest = 2
$largest_seq = []
File.open('input.txt').each { |connection|
  left, right = connection.chomp.split('-').map{ |id| $nodes[id] ||= Node.new(id) }
  left.add_connection(right)
  right.add_connection(left)
}
$nodes.values.each(&:largest)
pp $largest_seq.join(',')
