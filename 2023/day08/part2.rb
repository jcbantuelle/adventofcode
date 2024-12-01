directions = nil
nodes = {}
File.open('input.txt').each_line.map(&:chomp).each { |line|
  if directions.nil?
    directions = line.each_char.map{|direction| direction == 'L' ? 0 : 1}
  elsif line.empty?
    next
  else
    node = line.split(' = ')
    destinations = node[1].split(', ')
    nodes[node[0]] = [destinations[0][1..-1], destinations[1][0..-2], nil]
  end
}

active_nodes = nodes.keys.select{|node| node[-1] == 'A'}
steps = 0
direction_count = directions.length
while nodes.select{|node, _| node[-1] == 'Z'}.any?{|_, node| node[2].nil? }
  direction = directions[steps%direction_count]
  active_nodes = active_nodes.map{ |node|
    destination = nodes[node][direction]
    if nodes[destination][2].nil? && destination[-1] == 'Z'
      nodes[destination][2] = steps+1
    end
    destination
  }
  steps += 1
end

# Ran this result through an LCM calculator online
puts nodes.select{|node,_| node[-1] == 'Z'}.map{|_,node| node[2]}.join(' ')
