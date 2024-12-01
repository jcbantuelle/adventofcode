require 'pp'

nodes = []
25.times do |i|
  nodes.push(Array.new(35, nil))
end

count = 0
File.foreach('input.txt') do |line|
  count += 1
  next if count == 1 || count == 2
  node = line.chomp.split(' ')
  coords = node[0].split('-')
  x = coords[1][1..-1].to_i
  y = coords[2][1..-1].to_i
  nodes[y][x] = {
    max: node[1][0..-2].to_i,
    used: node[2][0..-2].to_i,
    available: node[3][0..-2].to_i,
    usage: node[4][0..-2].to_i
  }
end

pairs = 0
nodes.each_with_index do |row, i|
  row.each_with_index do |node, j|
    next if node[:used] == 0
    nodes.each_with_index do |comparison_row, k|
      comparison_row.each_with_index do |comparison_node, l|
        next if i == k && j == l
        pairs += 1 if node[:used] <= comparison_node[:available]
      end
    end
  end
end
pp pairs
