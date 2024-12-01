require 'pp'

a = 703
b = 516
count = 0

a_matches = []
b_matches = []

a_length = 0
b_length = 0

start = Time.now
while a_length < 5_000_000 || b_length < 5_000_000 do
  if a_length < 5_000_000
    a = a * 16807 % 2147483647
    if a % 4 == 0
      a_matches.push(a.to_s(2).rjust(16, '0')[-16..-1])
      a_length += 1
    end
  end
  if b_length < 5_000_000
    b = b * 48271 % 2147483647
    if b % 8 == 0
      b_matches.push(b.to_s(2).rjust(16, '0')[-16..-1])
      b_length += 1
    end
  end
end
pp Time.now-start

a_matches.each_with_index do |a, i|
  count += 1 if a == b_matches[i]
end

pp Time.now-start

pp count
