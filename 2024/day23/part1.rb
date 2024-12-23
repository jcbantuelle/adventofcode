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

  def groupings
    connection_keys = @connections.keys
    @connections.values.each { |node|
      overlap = node.connections.keys & connection_keys
      unless overlap.empty?
        overlap.each { |o|
          trio = [o, node.id, @id].sort
          $groupings[trio.join(',')] = trio
        }
      end
    }
  end
end

nodes = {}
$groupings = {}
File.open('input.txt').each { |connection|
  left, right = connection.chomp.split('-').map{ |id| nodes[id] ||= Node.new(id) }
  left.add_connection(right)
  right.add_connection(left)
}

nodes.values.each(&:groupings)
pp $groupings.values.select{|trio| trio.any?{|computer| computer[0] == 't'}}.length
