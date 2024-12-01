require 'pp'
require 'digest'

key = 'reyedfim'
passcode = ''

counter = 0

while passcode.length < 8
  md5hash = Digest::MD5.hexdigest("#{key}#{counter}")
  passcode += md5hash[5] if md5hash[0..4] == '00000'
  counter += 1
end

pp passcode
