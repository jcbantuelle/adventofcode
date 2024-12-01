require 'pp'

target = 3005290
winner = 9
while winner < target do
  next_winner = winner * 3
  break if next_winner > target
  winner = next_winner
end

elf = 0
(winner+1).upto(target) do |i|
  elf += i <= winner+winner ? 1 : 2
end
pp elf
