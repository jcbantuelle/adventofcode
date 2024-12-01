require 'pp'

used = 0

128.times do |i|
  key = "hxtvlmkl-#{i}"

  input = key.each_byte.to_a + [17, 31, 73, 47, 23]
  string = (0..255).to_a
  skip = 0
  current_position = 0

  64.times do
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
  end

  dense = []
  16.times do
    block = []
    16.times do
      block.push(string.shift)
    end
    dense.push(block.reduce(&:^))
  end

  used += dense.map{|number| number.to_s(2).rjust(8, '0')}.join('').count('1')
end

pp used
