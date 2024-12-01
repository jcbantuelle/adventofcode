require 'pp'

open_chars = ['[', '<', '{', '(']
close_chars = [']', '>', '}', ')']
points = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}
incompletes = []

File.foreach('input.txt') do |line|
  line = line.chomp
  opened = []
  valid = true
  line.each_char.to_a.each_with_index do |letter, index|
    if open_chars.include?(letter)
      opened.push(letter)
    else
      valid_char = close_chars[open_chars.find_index(opened.pop)]
      if letter != valid_char
        valid = false
        break
      end
    end
  end
  if valid && opened.length > 0
    incompletes.push(opened.reverse.inject(0){ |score, letter|
      close_letter = close_chars[open_chars.find_index(letter)]
      letter_score = points[close_letter]
      score = score * 5 + letter_score
    })
  end
end

pp incompletes.sort[incompletes.length/2]
