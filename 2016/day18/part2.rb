require 'pp'

start = '.^^^^^.^^.^^^.^...^..^^.^.^..^^^^^^^^^^..^...^^.^..^^^^..^^^^...^.^.^^^^^^^^....^..^^^^^^.^^^.^^^.^^'
safe = 0
max_index = start.length-1

current_row = start.each_char.to_a.map{|tile|
  safe += 1 if tile == '.'
  tile == '.' ? 1 : 0
}

399999.times do |i|
  pp i if i % 1000 == 0
  next_row = []
  current_row.each_with_index do |tile, index|
    tile_check = []
    tile_check.push(index == 0 ? 1 : current_row[index-1])
    tile_check.push(tile)
    tile_check.push(index == max_index ? 1 : current_row[index+1])
    next_row.push(%w(001 100 011 110).include?(tile_check.join('')) ? 0 : 1)
  end
  current_row = next_row
  safe += current_row.inject(&:+)
end
pp safe
