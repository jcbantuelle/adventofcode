letter_index = ('a'..'z').to_a + ('A'..'Z').to_a

puts File.open('input.txt').each_line.map{ |line|
  sack = line.chomp.chars
  compartments = sack.each_slice(sack.length / 2).to_a
  common_letter = (compartments[0] & compartments[1]).first
  letter_index.find_index(common_letter) + 1
}.inject(&:+)
