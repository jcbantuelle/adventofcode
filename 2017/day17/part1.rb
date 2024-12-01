require 'pp'

step = 356
buffer = [0]
position = 0

start = Time.now
2017.times do |i|
  value = i + 1
  position = (position + step) % buffer.length + 1
  buffer.insert(position, value)
end
pp Time.now-start

pp buffer[buffer.find_index{|b| b == 2017}+1]
