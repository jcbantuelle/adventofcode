enabled = true
puts File.open('input.txt').reduce(0) { |total, memory|
  total + memory.scan(/(mul\((\d+),(\d+)\)|do\(\)|don't\(\))/).reduce(0) {|sum, instruction|
    if instruction[0] == "do()"
      enabled = true
    elsif instruction[0] == "don't()"
      enabled = false
    elsif enabled
      sum += (instruction[1].to_i * instruction[2].to_i)
    end
    sum
  }
}
