require 'pp'

score = 0
open_chars = ['[', '<', '{', '(']
close_chars = [']', '>', '}', ')']
points = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137
}

File.foreach('input.txt') do |line|
  line = line.chomp
  opened = []
  line.each_char.to_a.each_with_index do |letter, index|
    if open_chars.include?(letter)
      opened.push(letter)
    else
      valid_char = close_chars[open_chars.find_index(opened.pop)]
      if letter != valid_char
        score += points[letter]
        next
      end
    end
  end
end

pp score
