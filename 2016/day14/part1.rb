require 'pp'
require 'digest'

key = 'cuanljph'

hashes = []
counter = 0
found = 0

while found < 64
  hashes[counter] = Digest::MD5.hexdigest("#{key}#{counter}") if hashes[counter].nil?
  triple = hashes[counter].match(/(.)\1{2}/)
  if triple
    (counter+1).upto(counter+1001) do |i|
      hashes[i] = Digest::MD5.hexdigest("#{key}#{i}") if hashes[i].nil?
      if hashes[i].match(/(#{triple[1]})\1{4}/)
        found += 1
        break
      end
    end
  end
  counter += 1
end

pp counter-1
