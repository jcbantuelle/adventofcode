require 'pp'

sum = 0

File.foreach('input.txt') do |line|
  room_data = line.chomp.match(/([[a-z]*\-]*)\-([\d]*)\[([a-z]*)\]/)
  room_name = room_data[1].gsub('-', '')
  room_id = room_data[2].to_i
  checksum = room_data[3]

  frequency = []
  room_name.each_char do |letter|
    letter_index = frequency.find_index { |pair|
      pair[0] == letter
    }
    if letter_index.nil?
      frequency.push([letter, 1])
    else
      frequency[letter_index][1] += 1
    end
  end
  sorted_frequency = frequency.sort { |elem1, elem2|
    if elem1[1] == elem2[1]
      elem1[0] <=> elem2[0]
    else
      elem2[1] <=> elem1[1]
    end
  }
  frequency_checksum = sorted_frequency[0..4].map{ |freq|
    freq[0]
  }.join('')
  sum += room_id if checksum == frequency_checksum
end

pp sum