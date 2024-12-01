require 'pp'

target = 3005290
winner = 63
while winner < target do
  next_winner = winner * 2 + 1
  break if next_winner > target
  winner = next_winner
end

elf = -1
(winner+1).upto(target) do
  elf += 2
end
pp elf
