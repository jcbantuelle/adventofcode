require 'pp'

step = 356
position = 0
answer = nil

start = Time.now
50_000_000.times do |i|
  value = i + 1
  position = (position + step) % value + 1
  answer = value if position == 1
end
pp Time.now-start

pp answer
