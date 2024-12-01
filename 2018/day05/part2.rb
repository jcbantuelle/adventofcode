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

shortest_length = nil

deletions[0..25].each do |unit|
  new_polymer = polymer.delete(unit)

  old_length = 0
  while new_polymer.length != old_length do
    old_length = new_polymer.length

    deletions.each do |deletion|
      new_polymer.gsub!(deletion, '')
    end
  end

  shortest_length = new_polymer.length if shortest_length.nil? || new_polymer.length < shortest_length
end

pp shortest_length
