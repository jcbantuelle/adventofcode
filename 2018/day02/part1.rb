require 'pp'

two_count = 0
three_count = 0

File.foreach('input.txt') do |line|
  frequencies = {}
  two_count_found = false
  three_count_found = false
  line.chomp.each_char do |letter|
    frequencies[letter] = 0 if frequencies[letter].nil?
    frequencies[letter] += 1
  end
  frequencies.each do |letter, value|
    if value == 2 && !two_count_found
      two_count += 1
      two_count_found = true
    end
    if value == 3 && !three_count_found
      three_count += 1
      three_count_found = true
    end
  end
end

pp two_count * three_count
