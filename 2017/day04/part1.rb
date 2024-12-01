require 'pp'

passphrases = []

File.foreach('input.txt') do |line|
  passphrases.push(line.chomp.split(' '))
end

pp passphrases.select { |passphrase|
  passphrase.length == passphrase.uniq.length
}.length
