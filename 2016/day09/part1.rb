require 'pp'

compressed = nil
File.foreach('input.txt') do |line|
  compressed = line.chomp
  break
end

expanded = ''
while !compressed.empty?
  if compressed[0] == '('
    expansion = compressed.match(/^\((\d*)x(\d*)\)/)
    compressed.slice!(0..expansion[0].length-1)
    segment = compressed.slice!(0..(expansion[1].to_i-1))
    expansion[2].to_i.times do
      expanded += segment
    end
  else
    expanded += compressed.slice!(0)
  end
end

pp expanded.length
