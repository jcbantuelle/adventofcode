require 'pp'

groups = []
garbage = false
letters = nil
score = 0

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
    garbage = false if character == '>'
  else
    if character == '<'
      garbage = true
    elsif character == '{'
      groups.push(true)
      score += groups.length
    elsif character == '}'
      groups.pop
    end
  end
  letter_index += 1
end

pp score
