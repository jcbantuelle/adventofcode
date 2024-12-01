require 'pp'

def add_border(image, i)
  value = i % 2 == 1 ? 1 : 0
  new_image = image.map{ |row|
    [value,value] + row.dup + [value,value]
  }
  2.times do
    new_image.unshift(Array.new(new_image[0].length, value))
    new_image.push(Array.new(new_image[0].length, value))
  end
  new_image
end

algorithm = nil
image = []
File.foreach('input.txt') do |line|
  line = line.chomp
  if algorithm.nil?
    algorithm = line.each_char.to_a.map{|pixel| pixel == '.' ? 0 : 1}
  elsif line.empty?
    next
  else
    image.push(line.each_char.to_a.map{|pixel| pixel == '.' ? 0 : 1})
  end
end

50.times do |i|
  image = add_border(image, i)
  new_image = image.map{|row|row.dup}
  image.each_with_index do |row, y_pos|
    next if y_pos - 1 < 0 || image[y_pos+1].nil?
    row.each_with_index do |pixel, x_pos|
      next if x_pos - 1 < 0 || row[x_pos+1].nil?
      pixel_binary = ''
      -1.upto(1) do |y_mod|
        -1.upto(1) do |x_mod|
          pixel_binary += image[y_pos+y_mod][x_pos+x_mod].to_s
        end
      end
      pixel_decimal = pixel_binary.to_i(2)
      new_image[y_pos][x_pos] = algorithm[pixel_decimal]
    end
  end
  image = new_image
  value = i % 2 == 0 ? 1 : 0
  image[0] = Array.new(image.length, value)
  image[image.length-1] = Array.new(image.length, value)
  image.each do |row|
    row[0] = value
    row[row.length-1] = value
  end
end

pp image.flatten.inject(&:+)
