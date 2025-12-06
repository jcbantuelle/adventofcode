position = 50
puts File.open('input.txt').reduce(0) { |password, instruction|
  direction = instruction[0]
  distance = instruction[1..-1].to_i

  mod = direction == 'R' ? 1 : -1
  distance.times do
    position += mod
    position = 99 if position == -1
    position = 0 if position == 100
    password += 1 if position == 0
  end
  password
}
