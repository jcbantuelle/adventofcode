require 'pp'

pots = '#......##...#.#.###.#.##..##.#.....##....#.#.##.##.#..#.##........####.###.###.##..#....#...###.##'.chars

transformations = {}
File.foreach('input.txt') do |line|
  transformation = line.chomp.split(' => ')
  transformations[transformation[0]] = transformation[1]
end

index_mod = 0

20.times do
  3.times do
    index_mod -= 1
    pots.unshift('.')
    pots.push('.')
  end
  new_pots = pots.dup
  pots.each_with_index do |pot, i|
    next if i < 2 || i > pots.length - 3
    segment = pots[i-2] + pots[i-1] + pot + pots[i+1] + pots[i+2]
    next_gen = transformations[segment] || '.'
    new_pots[i] = next_gen
  end
  while new_pots[0] == '.'
    new_pots.shift
    index_mod += 1
  end
  while new_pots[-1] == '.'
    new_pots.pop
  end
  pots = new_pots
end

total = 0
pots.each do |pot|
  total += index_mod if pot == '#'
  index_mod += 1
end
pp total
