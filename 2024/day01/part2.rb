list, frequency = File.open('input.txt').reduce([[],{}]) { |locations, pair|
  l, r = pair.chomp.split(' ').map(&:to_i)
  locations[0] << l
  locations[1][r] ||= 0
  locations[1][r] += 1
  locations
}

puts list.reduce(0){ |score, id|
  freq = frequency[id] || 0
  score + (id * freq)
}
