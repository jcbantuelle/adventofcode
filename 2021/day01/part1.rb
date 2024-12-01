deeper = 0
previous_depth = nil

File.foreach('input.txt') do |line|
  current_depth = line.to_i
  deeper += 1 if previous_depth && previous_depth < current_depth
  previous_depth = current_depth
end

puts deeper
