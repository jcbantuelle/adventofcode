require 'pp'

$nodes = {}
$routes = []

def traverse(node_name, visited)
  visited.push(node_name)
  if node_name == 'end'
    $routes.push(visited)
  else
    visited_small_nodes = visited.select{|node| node.downcase == node}
    visited_small_nodes = [] if visited_small_nodes == visited_small_nodes.uniq
    options = $nodes[node_name] - visited_small_nodes
    return if options.empty?
    options.each do |option|
      traverse(option, visited.dup)
    end
  end
end

File.foreach('input.txt') do |line|
  connection = line.chomp.split('-')
  0.upto(1) do |connection_index|
    if $nodes[connection[connection_index]].nil?
      $nodes[connection[connection_index]] = []
    end

    unless connection[connection_index] == 'end'
      connected_index = (connection_index+1)%2
      $nodes[connection[connection_index]].push(connection[connected_index]) unless connection[connected_index] == 'start'
    end
  end
end

traverse('start', [])
pp $routes.length
