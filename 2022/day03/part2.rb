letter_index = ('a'..'z').to_a + ('A'..'Z').to_a

puts File.open('input.txt').each_line.map{|line| line.chomp.chars}.each_slice(3).map{|group|
  common_letter = (group[0] & group[1] & group[2]).first
  letter_index.find_index(common_letter) + 1
}.inject(&:+)
