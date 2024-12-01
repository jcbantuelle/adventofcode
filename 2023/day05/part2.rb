def map_seeds(seeds, mapping)
  new_seeds = []
  while !seeds.empty? do
    seed = seeds.shift
    start_map = mapping.find{|map| map[0] <= seed[0] && map[1] >= seed[0]}
    if start_map.nil?
      end_map = mapping.find{|map| map[0] > seed[0] && map[0] <= seed[1]}
      if end_map.nil?
        new_seeds << seed
      else
        new_seeds << [seed[0],end_map[0]-1]
      end
    else
      if start_map[1] < seed[1]
        seeds << [start_map[1]+1, seed[1]]
        seed = [seed[0],start_map[1]]
      end
      new_seeds << seed.map{|s| s+start_map[2]}
    end
  end
  new_seeds.sort_by{|seed| seed[0]}
end

seeds = nil
mapping = []
File.open('input.txt').each_line.map(&:chomp).each { |line|
  if line.empty?
    if !mapping.empty?
      seeds = map_seeds(seeds, mapping)
      mapping = []
    end
    next
  end
  if seeds.nil?
    seeds = line.split(': ')[1].split(' ').map(&:to_i).each_slice(2).to_a.map{|seed| [seed[0],seed[0]+seed[1]-1]}.sort_by{|seed| seed[0]}
  else
    next if line.include?('map')
    map = line.split(' ').map(&:to_i)
    mapping << [map[1], map[1]+map[2]-1, map[0]-map[1]]
  end
}
puts map_seeds(seeds, mapping).sort_by{|s| s[0]}[0][0]
