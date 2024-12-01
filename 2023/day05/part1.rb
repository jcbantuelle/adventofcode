require 'pp'

section = -1
seeds = []
mappings = []
File.open('input.txt').each_line.map(&:chomp).each { |line|
  if line.empty?
    section += 1
    mappings[section] = []
    next
  end
  if section == -1
    seeds = line.split(': ')[1].split(' ').map(&:to_i)
  else
    next if line.include?('map')
    mapping = line.split(' ').map(&:to_i)
    mappings[section] << [mapping[1], mapping[1]+mapping[2]-1, mapping[0]-mapping[1]]
  end
}

pp seeds.map{|seed|
  location = seed
  7.times do |map|
    seed_map = mappings[map].find{|mapping|
      mapping[0] <= location && mapping[1] >= location
    }
    unless seed_map.nil?
      location += seed_map[2]
    end
  end
  location
}.sort.first
