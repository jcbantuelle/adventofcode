require 'pp'
require 'digest'

key = 'ckczppom'

counter = 1

while true
  result = Digest::MD5.hexdigest("#{key}#{counter}")[0..5]
  break if result == '000000'
  counter += 1
end

pp counter
