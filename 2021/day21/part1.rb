require 'pp'

players = [
  {
    position: 1,
    score: 0
  },
  {
    position: 4,
    score: 0
  }
]

die = 1
die_rolls = 0
done = false

while !done do
  0.upto(1) do |p|
    player = players[p]
    3.times do
      player[:position] += die
      die_rolls += 1
      die += 1
      die = 1 if die == 101
    end
    player[:position] %= 10
    player[:score] += player[:position]+1
    if player[:score] >= 1000
      done = true
      break
    end
  end
end

pp players.map{|p| p[:score]}.min * die_rolls
