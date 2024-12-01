require 'pp'

input = [88,88,211,106,141,1,78,254,2,111,77,255,90,0,54,205]
string = (0..255).to_a
skip = 0
current_position = 0

input.each do |length|
  next if length > string.length
  segment = length.times.reduce([]){|segment, index|
    segment_position = index + current_position
    segment_position -= string.length if segment_position >= string.length
    segment.push(string[segment_position])
  }.reverse
  length.times do |index|
    segment_position = index + current_position
    segment_position -= string.length if segment_position >= string.length
    string[segment_position] = segment[index]
  end
  current_position += length + skip
  current_position %= string.length if current_position >= string.length
  skip += 1
end

pp string[0] * string[1]
