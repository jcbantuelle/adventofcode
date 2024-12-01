require 'pp'

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
    nodes[node[0]] = [destinations[0][1..-1], destinations[1][0..-2]]
  end
}

current = 'AAA'
steps = 0
direction_count = directions.length
while current != 'ZZZ'
  direction = directions[steps%direction_count]
  current = nodes[current][direction]
  steps += 1
end
pp steps
