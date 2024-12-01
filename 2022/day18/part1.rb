require 'pp'

cubes = {}

File.open('input.txt').each_line do |line|
  coords = line.chomp.split(',').map(&:to_i)
  adjacent_cubes = [
    [coords[0]+1, coords[1], coords[2]],
    [coords[0]-1, coords[1], coords[2]],
    [coords[0], coords[1]+1, coords[2]],
    [coords[0], coords[1]-1, coords[2]],
    [coords[0], coords[1], coords[2]+1],
    [coords[0], coords[1], coords[2]-1]
  ]
  cubes[coords.join(',')] = adjacent_cubes.map{|cube| cube.join(',')}
end

open_faces = 0
cubes.each do |_, adjacent_cubes|
  open_faces += adjacent_cubes.reject{|cube| cubes[cube]}.length
end
pp open_faces
