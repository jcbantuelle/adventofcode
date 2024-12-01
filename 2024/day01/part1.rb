lists = File.open('input.txt').reduce([[],[]]) { |locations, pair|
  l, r = pair.chomp.split(' ').map(&:to_i)
  locations[0] << l
  locations[1] << r
  locations
}

left, right = lists.each(&:sort!)
puts left.zip(right).reduce(0) { |distance, pair|
  distance + (pair[0] - pair[1]).abs
}
