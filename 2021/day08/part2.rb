require 'pp'

displays = []

File.foreach('input.txt') do |line|
  output = line.chomp.split('|').map(&:strip)
  displays.push([output[0].split(' '), output[1].split(' ')])
end

total = 0

displays.each do |signal|
  outputs = signal[0]

  one = outputs.find{ |output|
    output.length == 2
  }.each_char.to_a.sort
  top_right = one.dup
  bottom_right = one.dup

  seven = outputs.find{ |output|
    output.length == 3
  }.each_char.to_a.sort
  top = seven - top_right

  four = outputs.find{ |output|
    output.length == 4
  }.each_char.to_a.sort
  remainder = four - top_right
  top_left = remainder.dup
  middle = remainder.dup

  three = outputs.find{ |output|
    output.length == 5 && output.index(top_right[0]) && output.index(top_right[1])
  }.each_char.to_a.sort
  bottom = three - top - top_right - middle
  middle = three - bottom - top_right - top
  top_left = top_left - middle

  eight = outputs.find{ |output|
    output.length == 7
  }.each_char.to_a.sort
  bottom_left = eight - top - top_left - middle - top_right - bottom

  six = outputs.find{ |output|
    output.length == 6 && output.index(top[0]) && output.index(top_left[0]) && output.index(middle[0]) && output.index(bottom_left[0]) && output.index(bottom[0])
  }.each_char.to_a.sort
  bottom_right = six - top - top_left - middle - bottom_left - bottom
  top_right = top_right - bottom_right

  zero = (top + top_left + top_right + bottom_left + bottom_right + bottom).sort
  two = (top + top_right + middle + bottom_left + bottom).sort
  five = (top + top_left + middle + bottom_right + bottom).sort
  nine = (top + top_left + top_right + middle + bottom_right + bottom).sort

  digits = [zero, one, two, three, four, five, six, seven, eight, nine]

  total += signal[1].map { |number|
    digits.find_index(number.each_char.to_a.sort).to_s
  }.join('').to_i
end

pp total
