require 'pp'

recipes = [3, 7]
elf1 = 0
elf2 = 1

target = 209231
while recipes.length < target+10 do
  recipe = recipes[elf1] + recipes[elf2]
  if recipe > 9
    recipes += recipe.to_s.chars.map(&:to_i)
  else
    recipes << recipe
  end
  elf1 = elf1 + recipes[elf1] + 1
  elf2 = elf2 + recipes[elf2] + 1
  while elf1 >= recipes.length
    elf1 -= recipes.length
  end
  while elf2 >= recipes.length
    elf2 -= recipes.length
  end
end

recipes.pop if recipes.length > target+10

pp recipes[-10..-1].join
