require 'pp'

monkeys = {}
waiting = {}

inputs = File.open('input.txt').each_line{ |line|
  split = line.chomp.split(': ')
  id = split[0]
  if /\d+/.match(split[1]).nil?
    params = /([a-z]{4})\s(.)\s([a-z]{4})/.match(split[1])[1..-1]
    waiting[id] = params
  else
    monkeys[id] = split[1].to_i
  end
}

while monkeys['root'].nil?
  new_waiting = {}
  waiting.each do |id, wait|
    left = wait[0].is_a?(String) && monkeys[wait[0]] ? monkeys[wait[0]] : wait[0]
    right = wait[2].is_a?(String) && monkeys[wait[2]] ? monkeys[wait[2]] : wait[2]
    if left.is_a?(String) || right.is_a?(String)
      new_waiting[id] = [left, wait[1], right]
      pp new_waiting if id == 'root'
    else
      monkeys[id] = left.send(wait[1], right)
    end
  end
  waiting = new_waiting
end

pp monkeys['root']
