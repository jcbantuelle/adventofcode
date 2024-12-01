require 'pp'

polymer = nil

File.foreach('input.txt') do |line|
  polymer = line.chomp
  break
end

deletions = (('a'..'z').to_a + ('A'..'Z').to_a).map { |letter|
  opposite = /[[:upper:]]/.match(letter) ? letter.downcase : letter.upcase
  "#{letter}#{opposite}"
}

old_length = 0

while polymer.length != old_length do
  old_length = polymer.length

  deletions.each do |deletion|
    polymer.gsub!(deletion, '')
  end
end

pp polymer.length
