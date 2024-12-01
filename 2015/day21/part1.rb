require 'pp'

items = [
  {
    name: 'Dagger',
    type: :weapon,
    cost: 8,
    damage: 4,
    armor: 0
  },
  {
    name: 'Shortsword',
    type: :weapon,
    cost: 10,
    damage: 5,
    armor: 0
  },
  {
    name: 'Warhammer',
    type: :weapon,
    cost: 25,
    damage: 6,
    armor: 0
  },
  {
    name: 'Longsword',
    type: :weapon,
    cost: 40,
    damage: 7,
    armor: 0
  },
  {
    name: 'Greataxe',
    type: :weapon,
    cost: 74,
    damage: 8,
    armor: 0
  },
  {
    name: 'Leather',
    type: :armor,
    cost: 13,
    damage: 0,
    armor: 1
  },
  {
    name: 'Chainmail',
    type: :armor,
    cost: 31,
    damage: 0,
    armor: 2
  },
  {
    name: 'Splintmail',
    type: :armor,
    cost: 53,
    damage: 0,
    armor: 3
  },
  {
    name: 'Bandedmail',
    type: :armor,
    cost: 75,
    damage: 0,
    armor: 4
  },
  {
    name: 'Platemail',
    type: :armor,
    cost: 102,
    damage: 0,
    armor: 5
  },
  {
    name: 'Damage +1',
    type: :ring,
    cost: 25,
    damage: 1,
    armor: 0
  },
  {
    name: 'Damage +2',
    type: :ring,
    cost: 50,
    damage: 2,
    armor: 0
  },
  {
    name: 'Damage +3',
    type: :ring,
    cost: 100,
    damage: 1,
    armor: 0
  },
  {
    name: 'Defense +1',
    type: :ring,
    cost: 20,
    damage: 0,
    armor: 1
  },
  {
    name: 'Defense +2',
    type: :ring,
    cost: 40,
    damage: 0,
    armor: 2
  },
  {
    name: 'Defense +3',
    type: :ring,
    cost: 80,
    damage: 0,
    armor: 3
  }
]

purchases = []
1.upto(4) do |i|
  purchases += items.combination(i).to_a
end

purchases.reject!{|purchase|
  purchase.select{|item| item[:type] == :weapon}.length > 1 ||
  purchase.select{|item| item[:type] == :armor}.length > 1 ||
  purchase.select{|item| item[:type] == :ring}.length > 2
}

purchases.sort_by! { |purchase|
  purchase.inject(0) {|total, item| total + item[:cost] }
}

purchases.each do |purchase|
  total = purchase.inject([0,0]) {|total, item|
    [total[0] + item[:damage], total[1] + item[:armor]]
  }
  player = {
    health: 100,
    damage: total[0],
    armor: total[1]
  }
  boss = {
    health: 104,
    damage: 8,
    armor: 1
  }

  while player[:health] > 0 do
    boss[:health] -= (player[:damage] - boss[:armor])
    if boss[:health] <= 0
      pp purchase
      pp purchase.inject(0) {|total, item| total + item[:cost] }
      exit
    end
    player[:health] -= (boss[:damage] - player[:armor])
  end
end
