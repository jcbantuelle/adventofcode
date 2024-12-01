require 'pp'

cycle = 0
register = 1
check_cycle = 20
signal_sum = 0
File.open('input.txt').each_line{ |line|
  instruction = line.chomp.split(' ')
  if instruction[0] == 'noop'
    cycle += 1
    if cycle == check_cycle
      signal_sum += cycle * register
      check_cycle += 40
    end
  else
    cycle += 1
    if cycle == check_cycle
      signal_sum += cycle * register
      check_cycle += 40
    end
    cycle += 1
    if cycle == check_cycle
      signal_sum += cycle * register
      check_cycle += 40
    end
    register += instruction[1].to_i
  end
}

pp signal_sum
