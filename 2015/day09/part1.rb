require 'pp'

paths = []

File.foreach('input.txt') do |line|
  path = line.chomp.match(/([A-Za-z]*)\sto\s([A-Za-z]*)\s=\s(\d*)/)
  paths.push({
    start: path[1],
    end: path[2],
    distance: path[3].to_i
  })
  paths.push({
    start: path[2],
    end: path[1],
    distance: path[3].to_i
  })
end

locations = paths.map{|path| [path[:start],path[:end]] }.flatten.uniq.permutation.to_a

pp locations.map{ |location|
  distance = 0
  location.each_with_index do |path_start, index|
    break if location[index+1].nil?
    path_end = location[index+1]
    distance += paths.find{|path| path[:start] == path_start && path[:end] == path_end}[:distance]
  end
  distance
}.sort.first
