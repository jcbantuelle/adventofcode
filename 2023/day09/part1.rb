require 'pp'

pp File.open('input.txt').each_line.map(&:chomp).inject(0) { |sum, line|
  sequence = [line.split(' ').map(&:to_i)]
  while true
    a = 0
    b = 1
    eval_sequence = sequence[-1]
    new_sequence = []
    while b < eval_sequence.length
      new_sequence << eval_sequence[b] - eval_sequence[a]
      a += 1
      b += 1
    end
    sequence << new_sequence
    break if new_sequence.all?{|s| s == 0}
  end
  extra_val = 0
  (sequence.length-2).downto(0) do |i|
    append = sequence[i][-1] + extra_val
    sequence[i] << append
    extra_val = append
  end
  sum += extra_val
}
