require 'pp'

$nodes = {}

def traverse(node_name, visited)
  visited_small_nodes = visited.select{|node| node.downcase == node}
  options = $nodes[node_name] - visited_small_nodes
  if options.empty?
    return 0
  else
    return options.map{ |option|
      if option == 'end'
        1
      else
        traverse(option, visited.dup.push(node_name))
      end
    }.inject(&:+)
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

pp traverse('start', [])
