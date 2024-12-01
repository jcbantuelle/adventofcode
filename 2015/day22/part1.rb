require 'pp'

least_mana = 10000000

turns = [{
  player_hp: 50,
  mana: 500,
  boss_hp: 71,
  mana_spent: 0,
  shield: 0,
  poison: 0,
  recharge: 0
}]

loop do
  next_turns = []
  turns.each do |turn|
    # Player Turn
    turn[:mana] += 101 if turn[:recharge] > 0
    turn[:boss_hp] -= 3 if turn[:poison] > 0
    turn[:shield] -= 1
    turn[:poison] -= 1
    turn[:recharge] -= 1
    if turn[:boss_hp] <= 0
      least_mana = turn[:mana_spent] if turn[:mana_spent] < least_mana
    else
      if turn[:mana] >= 53
        # Magic Missile
        next_turn = turn.dup
        next_turn[:mana] -= 53
        next_turn[:boss_hp] -= 4
        next_turn[:mana_spent] += 53
        next_turns.push(next_turn) unless next_turn[:mana_spent] > least_mana

        # Drain
        if turn[:mana] >= 73
          next_turn = turn.dup
          next_turn[:mana] -= 73
          next_turn[:boss_hp] -= 2
          next_turn[:player_hp] += 2
          next_turn[:mana_spent] += 73
          next_turns.push(next_turn) unless next_turn[:mana_spent] > least_mana
        end

        # Shield
        if turn[:mana] >= 113 && turn[:shield] <= 0
          next_turn = turn.dup
          next_turn[:mana] -= 113
          next_turn[:shield] = 6
          next_turn[:mana_spent] += 113
          next_turns.push(next_turn) unless next_turn[:mana_spent] > least_mana
        end

        # Poison
        if turn[:mana] >= 173 && turn[:poison] <= 0
          next_turn = turn.dup
          next_turn[:mana] -= 173
          next_turn[:poison] = 6
          next_turn[:mana_spent] += 173
          next_turns.push(next_turn) unless next_turn[:mana_spent] > least_mana
        end

        # Recharge
        if turn[:mana] >= 229 && turn[:recharge] <= 0
          next_turn = turn.dup
          next_turn[:mana] -= 229
          next_turn[:recharge] = 5
          next_turn[:mana_spent] += 229
          next_turns.push(next_turn) unless next_turn[:mana_spent] > least_mana
        end
      end
    end
  end
  next_turns.reject!{ |next_turn|
    reject_turn = false
    next_turn[:mana] += 101 if next_turn[:recharge] > 0
    next_turn[:boss_hp] -= 3 if next_turn[:poison] > 0
    next_turn[:shield] -= 1
    next_turn[:poison] -= 1
    next_turn[:recharge] -= 1
    if next_turn[:boss_hp] <= 0
      least_mana = next_turn[:mana_spent] if next_turn[:mana_spent] < least_mana
      reject_turn = true
    else
      next_turn[:player_hp] -= next_turn[:shield] > 0 ? 3 : 10
      reject_turn = true if next_turn[:player_hp] <= 0
    end
    reject_turn
  }
  break if next_turns.empty?
  turns = next_turns
end

pp least_mana
