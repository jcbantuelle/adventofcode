require 'pp'

box_ids = []

File.foreach('input.txt') do |line|
  box_ids.push(line.chomp)
end

box_ids.each_with_index do |box, index|
  box_ids.each_with_index do |box2, index2|
    next if index == index2
    different_characters = 0
    common_chars = ''
    box.each_char.to_a.each_with_index do |letter, letter_index|
      if letter != box2[letter_index]
        different_characters += 1
      else
        common_chars += letter
      end
      break if different_characters > 1
    end
    if different_characters == 1
      pp common_chars
      exit
    end
  end
end
