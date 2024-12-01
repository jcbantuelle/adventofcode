require 'pp'

digits = nil

File.foreach('input.txt') do |line|
  digits = line.chomp.scan(/(\-?\d+)/)
  break
end

pp digits.flatten.map(&:to_i).inject(&:+)
