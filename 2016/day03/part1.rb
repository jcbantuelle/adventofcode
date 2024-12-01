require 'pp'

triangles = []

File.foreach('input.txt') do |line|
  triangles.push(line.chomp.split(' ').map(&:to_i))
end

pp triangles.select {|triangle|
  triangle[0] + triangle[1] > triangle[2] &&
  triangle[1] + triangle[2] > triangle[0] &&
  triangle[0] + triangle[2] > triangle[1]
}.length
