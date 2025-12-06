position = 50
puts File.open('input.txt').reduce(0) { |password, instruction|
  direction = instruction[0]
  distance = instruction[1..-1].to_i
  distance *= -1 if direction == 'L'
  position += distance
  position %= 100
  password += 1 if position == 0
  password
}
