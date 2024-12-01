require 'pp'
require 'prime'

target = 34000000

house = 51
loop do
  prime_factors = Prime.prime_division(house).map{|factor| Array.new(factor[1], factor[0])}.flatten
  divisors = (1..prime_factors.length).map{ |i|
    prime_factors.combination(i).to_a
  }.flatten(1).uniq
  presents = 0
  divisors.each do |divisor|
    divisor = divisor.inject(&:*)
    presents += divisor*11 unless house / divisor > 50
  end
  break if presents >= target
  house += 1
end

pp house
