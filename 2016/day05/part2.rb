require 'pp'
require 'digest'

key = 'reyedfim'
passcode = '........'
valid_positions = '0123456789'

counter = 0
total = 0

while passcode.include?('.')
  md5hash = Digest::MD5.hexdigest("#{key}#{counter}")
  if md5hash[0..4] == '00000'
    position = md5hash[5]
    if valid_positions.include?(position)
      position = position.to_i
      passcode[position] = md5hash[6] if position >= 0 && position <= 7 && passcode[position] == '.'
    end
  end
  counter += 1
end

pp passcode
