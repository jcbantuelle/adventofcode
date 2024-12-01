require 'pp'

fill = '00101000101111010'
target = 272

while fill.length < target
  added = fill.reverse.each_char.map{|letter| letter == '0' ? '1' : '0'}.join('')
  fill += '0' + added
end
fill = fill[0..target-1]

checksum = fill
while checksum.length % 2 == 0
  checksum = checksum.each_char.each_slice(2).to_a.map{|pair|
    pair[0] == pair[1] ? '1' : '0'
  }.join('')
end
pp checksum
