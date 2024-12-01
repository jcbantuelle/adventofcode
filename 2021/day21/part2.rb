require 'pp'

def serialize_turn(turn)
  key = []
  turn[:players].each do |turn|
    key += [turn[:position],turn[:score]]
  end
  key.push(turn[:player_turn])
  key.join(',')
end

turns = [
  {
    players: [
      {
        position: 2,
        score: 0
      },
      {
        position: 5,
        score: 0
      }
    ],
    player_turn: 0,
    occurrences: 0
  }
]

occurrences = {}

score = [0,0]
possibilities = [3,4,5,4,5,6,5,6,7,4,5,6,5,6,7,6,7,8,5,6,7,6,7,8,7,8,9]
while !turns.empty?
  turns.each do |turn|
    player_turn = turn[:player_turn]
    possibilities.each do |i|
      players = [
        turn[:players][0].dup,
        turn[:players][1].dup
      ]
      players[player_turn][:position] += i
      players[player_turn][:position] -= 10 if players[player_turn][:position] > 10
      players[player_turn][:score] += players[player_turn][:position]
      if players[player_turn][:score] >= 21
        score[player_turn] += turn[:occurrences]
      else
        next_turn = {
          players: players,
          player_turn: (player_turn+1)%2,
          occurrences: 0
        }
        turn_key = serialize_turn(next_turn)
        occurrences[turn_key] = next_turn if occurrences[turn_key].nil?
        occurrences[turn_key][:occurrences] += (turn[:occurrences] == 0 ? 1 : turn[:occurrences])
      end
    end
  end
  turns = occurrences.values
  occurrences = {}
end

pp score.max
