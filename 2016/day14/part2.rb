require 'pp'
require 'digest'

key = 'cuanljph'

hashes = []
counter = 0
found = 0

while found < 64
  if hashes[counter].nil?
    hashes[counter] = Digest::MD5.hexdigest("#{key}#{counter}") if hashes[counter].nil?
    2016.times do
      hashes[counter] = Digest::MD5.hexdigest(hashes[counter])
    end
  end
  triple = hashes[counter].match(/(.)\1{2}/)
  if triple
    (counter+1).upto(counter+1001) do |i|
      if hashes[i].nil?
        hashes[i] = Digest::MD5.hexdigest("#{key}#{i}") if hashes[i].nil?
        2016.times do
          hashes[i] = Digest::MD5.hexdigest(hashes[i])
        end
      end
      if hashes[i].match(/(#{triple[1]})\1{4}/)
        found += 1
        break
      end
    end
  end
  counter += 1
end

pp counter-1
