require 'pp'

total = 0
depths = []

File.foreach('input.txt') do |line|
  depths.push(line.chomp.to_i)
end

grouped_depths = depths.each_cons(3).to_a
grouped_depths.each_with_index do |depth, index|
  total += 1 unless grouped_depths[index+1].nil? || depth.inject(&:+) >= grouped_depths[index+1].inject(&:+)
end

pp total

pp depths.each_cons(3).to_a.map{ |depth|
  depth.inject(&:+)
}.reduce([0,nil]) {|tally, depth|
  tally[0] += 1 unless tally[1].nil? || tally[1] >= depth
  tally[1] = depth
  tally
}[0]
