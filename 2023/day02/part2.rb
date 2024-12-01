puts File.open('input.txt').each_line.map(&:chomp).inject(0) { |sum, game|
  cubes = {}
  game.chomp.split(':')[1].split(';').map(&:strip).each do |pull|
    pull.split(', ').map{ |cube|
      total, color = cube.split(' ')
      total = total.to_i
      cubes[color] = 0 unless cubes[color]
      cubes[color] = total unless cubes[color] > total
    }
  end
  sum + cubes.values.inject(&:*)
}
