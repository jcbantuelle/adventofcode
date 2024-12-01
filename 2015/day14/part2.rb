require 'pp'

reindeers = []

File.foreach('input.txt') do |line|
  reindeer = line.chomp.match(/^([A-Za-z]+).+\s(\d+)\s.+\s(\d+)\s.+\s(\d+)\s.+$/)
  reindeers.push({
    name: reindeer[1],
    speed: reindeer[2].to_i,
    duration: reindeer[3].to_i,
    rest: reindeer[4].to_i,
    distance: 0,
    score: 0
  })
end

timer = 2503

timer.times do |time|
  distances = []
  reindeers.each do |reindeer|
    travel_chunk = reindeer[:duration] + reindeer[:rest]
    elapsed = time % travel_chunk
    reindeer[:distance] += reindeer[:speed] if elapsed < reindeer[:duration]
    distances.push(reindeer[:distance])
  end
  winner = distances.max
  reindeers.select{|reindeer| reindeer[:distance] == winner}.each do |reindeer|
    reindeer[:score] += 1
  end
end

pp reindeers.map{|reindeer| reindeer[:score]}.max
