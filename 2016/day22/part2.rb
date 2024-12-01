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
  max = node[1][0..-2].to_i
  used = node[2][0..-2].to_i
  char = ''
  if max > 500
    char = '#'
  elsif x == 0 && y == 0
    char = 'G'
  elsif used == 0
    char = '_'
  else
    char = '.'
  end
  nodes[y][x] = {
    max: node[1][0..-2].to_i,
    used: node[2][0..-2].to_i,
    available: node[3][0..-2].to_i,
    usage: node[4][0..-2].to_i,
    char: char
  }
end

nodes.each do |row|
  puts row.map{|node| node[:char]}.join('')
end

# Manually counted distance to top-right corner
# 35 moves

# 5 moves to shift it left one space
# 33 spaces to top-left corner

# 35 + 5 * 33 = 200
