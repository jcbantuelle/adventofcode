require 'pp'

triangles = []

counter = 0
rows = []

File.foreach('input.txt') do |line|
  rows.push(line.chomp.split(' ').map(&:to_i))
  counter += 1
  if counter == 3
    triangles.push([rows[0][0], rows[1][0], rows[2][0]])
    triangles.push([rows[0][1], rows[1][1], rows[2][1]])
    triangles.push([rows[0][2], rows[1][2], rows[2][2]])
    counter = 0
    rows = []
  end
end

pp triangles.select {|triangle|
  triangle[0] + triangle[1] > triangle[2] &&
  triangle[1] + triangle[2] > triangle[0] &&
  triangle[0] + triangle[2] > triangle[1]
}.length
