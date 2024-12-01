require 'pp'

$cubes = {}
$pockets = {}
$min_x = 100000
$max_x = -100000
$min_y = 100000
$max_y = -100000
$min_z = 100000
$max_z = -100000

def pocket?(cube)
  return true if $pockets[cube]
  seen = {}
  unchecked_cubes = [cube]
  while unchecked_cubes.length > 0
    next_cube = unchecked_cubes.pop
    next if seen[next_cube]
    seen[next_cube] = true

    coords = next_cube.split(',').map(&:to_i)
    ranges = [
      [0, coords[0].downto($min_x).to_a],
      [0, coords[0].upto($max_x).to_a],
      [1, coords[1].downto($min_y).to_a],
      [1, coords[1].upto($max_y).to_a],
      [2, coords[2].downto($min_z).to_a],
      [2, coords[2].upto($max_z).to_a]
    ].each do |range|
      coord_index = range[0]
      collision = false
      range[1].each do |coord|
        new_coords = coords.clone
        new_coords[coord_index] = coord
        cube_index = new_coords.join(',')
        if $cubes[cube_index]
          collision = true
          break
        else
          unchecked_cubes << cube_index unless seen[cube_index]
        end
      end
      return false unless collision
    end
  end
  $pockets.merge!(seen)
  true
end

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
  $min_x = coords[0] - 1 if coords[0] - 1 < $min_x
  $max_x = coords[0] + 1 if coords[0] + 1 > $max_x
  $min_y = coords[1] - 1 if coords[1] - 1 < $min_y
  $max_y = coords[1] + 1 if coords[1] + 1 > $max_y
  $min_z = coords[2] - 1 if coords[2] - 1 < $min_z
  $max_z = coords[2] + 1 if coords[2] + 1 > $max_z
  $cubes[coords.join(',')] = adjacent_cubes.map{|cube| cube.join(',')}
end

start = Time.now
open_faces = 0
$cubes.each do |_, adjacent_cubes|
  open_cubes = adjacent_cubes.reject{|cube| $cubes[cube]}
  open_faces += open_cubes.reject{|cube|
    pocket?(cube)
  }.length
end
pp open_faces
pp "Finished in: #{Time.now - start}s"
