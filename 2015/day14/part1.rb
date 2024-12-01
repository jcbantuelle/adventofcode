require 'pp'

reindeers = []

File.foreach('input.txt') do |line|
  reindeer = line.chomp.match(/^([A-Za-z]+).+\s(\d+)\s.+\s(\d+)\s.+\s(\d+)\s.+$/)
  reindeers.push({
    name: reindeer[1],
    speed: reindeer[2].to_i,
    duration: reindeer[3].to_i,
    rest: reindeer[4].to_i
  })
end

timer = 2503

pp reindeers.map{ |reindeer|
  travel_chunk = reindeer[:duration] + reindeer[:rest]
  full, partial = timer.divmod(travel_chunk)
  partial_duration = partial > reindeer[:duration] ? reindeer[:duration] : partial
  distance = full * reindeer[:speed] * reindeer[:duration]
  distance += reindeer[:speed] * partial_duration
  [reindeer[:name], distance]
}.sort_by{|reindeer| reindeer[1]}.last[1]
