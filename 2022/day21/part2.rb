require 'pp'

monkeys = {}
waiting = {}
comparator = nil

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
monkeys.delete('humn')

done = false
while !done
  done = true
  new_waiting = {}
  waiting.each do |id, wait|
    left = nil
    right = nil
    if wait[0].is_a?(String) && monkeys[wait[0]]
      done = false
      left = monkeys[wait[0]]
    else
      left = wait[0]
    end
    if wait[2].is_a?(String) && monkeys[wait[2]]
      done = false
      right = monkeys[wait[2]]
    else
      right = wait[2]
    end
    if left.is_a?(String) || right.is_a?(String)
      new_waiting[id] = [left, wait[1], right]
    else
      if wait[1] == '/'
        pp "#{left} / #{right}"
      end
      monkeys[id] = left.send(wait[1], right)
    end
    if comparator.nil? && id == 'root' && (!left.is_a?(String) || !right.is_a?(String))
      comparator = left.is_a?(String) ? right : left
    end
  end
  waiting = new_waiting
end

search_term = 'humn'
expression = nil
loop do
  next_expression = waiting.find{|id, wait|
    wait[0] == search_term || wait[2] == search_term
  }
  break if next_expression[0] == 'root'
  unless expression.nil?
    if next_expression[1][0] == search_term
      next_expression[1][0] = expression
    else
      next_expression[1][2] = expression
    end
  end
  expression = "(#{next_expression[1].join})"
  search_term = next_expression[0]
end
pp "#{expression} = #{comparator}"

# test: ((4+(2*(x-3)))/4) = 150
# input: ((((92540050790154-(9*(((((280+(((((((2*(264+((516+(((660+(2*((2*(530+((((313+(((((3*(615+(((8*(915+((((246+(4*(((483+(((((((80+(((((8*((((3*(789+((107+((x-745)/3))*11)))-695)/4)-486))+570)/5)-757)/3))*5)+411)*2)-885)+552)+802))/2)-686)))/5)-175)/3)))-66)/2)))-319)*2)+133)+570))/2)-955)/2)))-768)))/3)-223))/5)))-933)/5)+765)*9)-193)*2))/2)+689)/6)-230)))*2)+138)/12) = 5697586809113
