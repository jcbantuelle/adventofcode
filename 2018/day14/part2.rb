require 'pp'

recipes = [3, 7]
elf1 = 0
elf2 = 1

target = '209231'
target_size = target.length + 1
target_index = nil

segment = recipes.map(&:to_s).join
while target_index.nil? do
  recipe = recipes[elf1] + recipes[elf2]
  segment += recipe.to_s
  recipe = recipe > 9 ? recipe.to_s.chars.map(&:to_i) : [recipe]
  recipes.concat(recipe)
  while segment.length > target_size
    segment.slice!(0)
  end
  elf1 += recipes[elf1] + 1
  elf2 += recipes[elf2] + 1
  while elf1 >= recipes.length
    elf1 -= recipes.length
  end
  while elf2 >= recipes.length
    elf2 -= recipes.length
  end
  if segment[0..-2] == target
    target_index = 0
  elsif segment[1..-1] == target
    target_index = 1
  end
end

pp recipes.length - target_size + target_index
