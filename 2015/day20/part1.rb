require 'pp'
require 'prime'

target = 3400000

house = 1

loop do
  presents = Prime.prime_division(house).inject(1) do |acc, factor|
    ((factor[0]**(factor[1]+1)-1)/(factor[0]-1))*acc
  end
  break if presents > target
  house += 1
end

pp house
