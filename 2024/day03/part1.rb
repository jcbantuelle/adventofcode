puts File.open('input.txt').reduce(0) { |sum, memory|
  sum + memory.scan(/mul\((\d+),(\d+)\)/).map{|a,b| a.to_i * b.to_i}.reduce(&:+)
}
