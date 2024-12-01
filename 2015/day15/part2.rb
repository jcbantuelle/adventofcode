require 'pp'

ingredients = []

File.foreach('input.txt') do |line|
  ingredient = line.chomp.match(/^([A-Za-z]+):\s.+\s(-?\d+),\s.+\s(-?\d+),\s.+\s(-?\d+),\s.+\s(-?\d+),\s.+\s(-?\d+)$/)
  ingredients.push({
    name: ingredient[1],
    capacity: ingredient[2].to_i,
    durability: ingredient[3].to_i,
    flavor: ingredient[4].to_i,
    texture: ingredient[5].to_i,
    calories: ingredient[6].to_i
  })
end

pp ingredients.repeated_combination(100).map{|possibility|
  capacity = 0
  durability = 0
  flavor = 0
  texture = 0
  calories = 0
  possibility.each do |ingredient|
    capacity += ingredient[:capacity]
    durability += ingredient[:durability]
    flavor += ingredient[:flavor]
    texture += ingredient[:texture]
    calories += ingredient[:calories]
  end
  if calories == 500
    capacity = 0 if capacity < 0
    durability = 0 if durability < 0
    flavor = 0 if flavor < 0
    texture = 0 if texture < 0
    capacity * durability * flavor * texture
  else
    0
  end
}.max
