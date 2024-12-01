require 'pp'

garbage = false
letters = nil
garbage_count = 0

File.foreach('input.txt') do |line|
  letters = line.chomp.each_char.to_a
  break
end

letter_index = 0
while letter_index < letters.length do
  character = letters[letter_index]
  if character == '!'
    letter_index += 1
  elsif garbage
    if character == '>'
      garbage = false
    else
      garbage_count += 1
    end
  else
    garbage = true if character == '<'
  end
  letter_index += 1
end

pp garbage_count
