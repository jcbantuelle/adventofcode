require 'pp'

matrix = Array.new
IO.readlines('input2.txt').each do |line|
  matrix.push(line.chomp.each_char.to_a.map{ |cell|
    {value: cell.to_i, distance: Float::INFINITY, visited: false}
  })
end

matrix.each_with_index do |row, y_pos|
  row.each_with_index do |cell, x_pos|
    cell[:neighbors] = []
    cell[:neighbors].push(matrix[y_pos-1][x_pos]) if y_pos > 0
    cell[:neighbors].push(matrix[y_pos][x_pos-1]) if x_pos > 0
    cell[:neighbors].push(matrix[y_pos+1][x_pos]) unless matrix[y_pos+1].nil?
    cell[:neighbors].push(matrix[y_pos][x_pos+1]) unless matrix[y_pos][x_pos+1].nil?
  end
end

max_index = matrix.size - 1
destination = matrix[max_index][max_index]
current = matrix[0][0]
current[:value] = 0
current[:distance] = 0
nodes = []

start = Time.now
while !destination[:visited] do
  current[:neighbors].each do |neighbor|
    distance = current[:distance] + neighbor[:value]
    neighbor[:distance] = distance if distance < neighbor[:distance]
  end
  current[:visited] = true
  nodes += current[:neighbors]
  nodes = nodes.reject{|node| node[:visited]}
  current = nodes.sort_by{|node| node[:distance]}.first
end
pp Time.now-start

pp destination[:distance]
