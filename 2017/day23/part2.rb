require 'pp'
require 'prime'

answer = 0

(109300..126300).step(17) do |t|
  answer += 1 unless Prime.prime?(t)
end

pp answer

puts (109300..126300).step(17).to_a.reject{|t| Prime.prime?(t)}.length
