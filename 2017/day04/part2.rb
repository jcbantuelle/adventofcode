require 'pp'

passphrases = []

File.foreach('input.txt') do |line|
  passphrases.push(line.chomp.split(' '))
end

pp passphrases.select { |passphrase|
  new_passphrase = passphrase.map{ |word|
    word.each_char.to_a.sort.join('')
  }
  new_passphrase.length == new_passphrase.uniq.length
}.length
