puts File.open('input.txt').reduce(0) { |sum, line|
  left, right = line.chomp.split(':')
  result = left.to_i
  operands = right.split(' ').map(&:to_i)
  first = operands.shift
  valid = [:+, :*].repeated_permutation(operands.length).any?{|operation|
    operands.each_with_index.reduce(first) {|total, operand|
      op = operation[operand[1]]
      total.send(op, operand[0])
    } == result
  }
  sum + (valid ? result : 0)
}
