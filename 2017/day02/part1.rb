require 'pp'

rows = []

File.foreach('input.txt') do |line|
  rows.push(line.chomp.split(' ').map(&:to_i))
end

pp rows.map { |row|
  row.max - row.min
}.inject(&:+)
