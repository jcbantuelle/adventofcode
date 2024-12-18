require 'pp'

lines = File.open('input.txt').map(&:chomp).to_a
$a = lines[0].scan(/\d+/)[0].to_i
$b = lines[1].scan(/\d+/)[0].to_i
$c = lines[2].scan(/\d+/)[0].to_i

def combo(op)
  case op
  when 0..3
    op
  when 4
    $a
  when 5
    $b
  when 6
    $c
  when 7
    puts 'Invalid Combo Operand'
    exit
  end
end

instructions = lines[4].scan(/\d+/).map(&:to_i).each_slice(2).to_a
pointer = 0

output = []
loop do
  break if pointer >= instructions.length
  instruction, op = instructions[pointer]
  pointer += 1
  case instruction
  when 0
    $a /= 2**combo(op)
  when 1
    $b ^= op
  when 2
    $b = combo(op) % 8
  when 3
    pointer = op unless $a == 0
  when 4
    $b ^= $c
  when 5
    output << (combo(op) % 8)
  when 6
    $b = $a / (2**combo(op))
  when 7
    $c = $a / (2**combo(op))
  end
end

pp output.join(',')
