require 'pp'

players = 428
last_marble = 7_082_500
current_player = 0
current_marble = 0
scores = Array.new(players, 0)

marbles = [0]

1.upto(last_marble) do |next_marble|
  if next_marble % 23 == 0
    current_marble -= 7
    current_marble += marbles.length if current_marble < 0
    scores[current_player] += next_marble + marbles.delete_at(current_marble)
    current_marble = 0 if marbles[current_marble].nil?
  else
    current_marble += 1
    current_marble = 0 if current_marble == marbles.length
    current_marble += 1
    marbles.insert(current_marble, next_marble)
  end
  current_player += 1
  current_player = 0 if current_player == players
end

pp scores.max
