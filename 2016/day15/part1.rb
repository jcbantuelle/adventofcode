require 'pp'

discs = [
  {max: 16, position: 5},
  {max: 18, position: 8},
  {max: 6, position: 1},
  {max: 12, position: 7},
  {max: 4, position: 1},
  {max: 2, position: 0},
]

discs.each_with_index do |disc, level|
  disc[:target] = disc[:max] - level
end
discs[5][:target] = 0

counter = 0
loop do
  break if discs.all?{|disc| disc[:position] == disc[:target]}
  discs.each do |disc|
    disc[:position] += 1
    disc[:position] = 0 if disc[:position] > disc[:max]
  end
  counter += 1
end

pp counter
