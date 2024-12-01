require 'pp'

a = 703
b = 516
count = 0

start = Time.now
40_000_000.times do
  a = a * 16807 % 2147483647
  b = b * 48271 % 2147483647
  count += 1 if a.to_s(2).rjust(16, '0')[-16..-1] == b.to_s(2).rjust(16, '0')[-16..-1]
end
pp Time.now-start
pp count
