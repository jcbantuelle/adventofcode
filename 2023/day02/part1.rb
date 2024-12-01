require 'pp'

actual = {
  'red' => 12,
  'green' => 13,
  'blue' => 14
}

valid = 0
game_index = 1
File.open('input.txt').each_line{ |game|
  good = true
  game.chomp.split(':')[1].split(';').map(&:strip).each do |pull|
    cubes = {}
    pull.split(', ').map{ |cube|
      total, color = cube.split(' ')
      cubes[color] = 0 unless cubes[color]
      cubes[color] += total.to_i
    }
    cubes.each do |cube, total|
      good = false if actual[cube] < total
    end
  end
  valid += game_index if good
  game_index += 1
}

pp valid
