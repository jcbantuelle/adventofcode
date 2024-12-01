require 'pp'

displays = []

File.foreach('input.txt') do |line|
  output = line.chomp.split('|').map(&:strip)
  displays.push([output[0].split(' '), output[1].split(' ')])
end

pp displays.map{|output|
  output[1].map{ |digit|
    digit.length == 2 || digit.length == 4 || digit.length == 3 || digit.length == 7 ? 1 : 0
  }.inject(&:+)
}.inject(&:+)
