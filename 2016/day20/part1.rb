require 'pp'

ranges = []

File.foreach('input.txt') do |line|
  ranges.push(line.chomp.split('-').map(&:to_i))
end

ranges.sort!{ |a,b|
  a[1] <=> b[1]
}

ranges.each do |range|
  check = range[1]+1
  if ranges.all? { |confirm| check < confirm[0] || check > confirm[1] }
    pp check
    exit
  end
end
