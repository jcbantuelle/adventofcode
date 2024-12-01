require 'pp'

def hashed(label)
  label.each_char.inject(0){|current, chr| ((current + chr.ord) * 17) % 256}
end

boxes = []
256.times do |i|
  boxes[i] = []
end

File.open('input.txt').each_line{ |line|
  line.chomp.split(',').each { |lens|
    if lens.include?('=')
      label, focal_length = lens.split('=')
      box = hashed(label)
      location = boxes[box].find_index{|l| l[0] == label}
      if location
        boxes[box][location][1] = focal_length.to_i
      else
        boxes[box].push([label,focal_length.to_i])
      end
    else
      label = lens.split('-')[0]
      box = hashed(label)
      boxes[box].reject!{|l| l[0] == label}
    end
  }
}

pp boxes.each_with_index.inject(0) { |sum, a|
  box = a[0]
  box_index = a[1] + 1
  unless box.empty?
    sum += box.each_with_index.inject(0) { |power, b|
      lens = b[0]
      lens_slot = b[1] + 1
      power + (box_index * lens_slot * lens[1])
    }
  end
  sum
}
