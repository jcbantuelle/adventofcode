puts File.open('input.txt').reduce(0) { |sum, line|
  left, right = line.chomp.split(':')
  result = left.to_i
  operands = right.split(' ').map(&:to_i)
  first = operands.shift
  valid = [:+, :*, :c].repeated_permutation(operands.length).any?{|operation|
    operands.each_with_index.reduce(first) {|total, operand|
      op = operation[operand[1]]
      if op == :c
        (total.to_s + operand[0].to_s).to_i
      else
        total.send(op, operand[0])
      end
    } == result
  }
  sum + (valid ? result : 0)
}
