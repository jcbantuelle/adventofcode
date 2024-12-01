require 'pp'

counter = 0

def factorial(n)
  (1..n).inject(&:*) || 1
end

counter = 1

pp File.open('input.txt').each_line.inject(0) { |sum, line|
  pp counter
  counter += 1
  mapping, check = line.chomp.split(' ')
  mapping = mapping.split('.').delete_if(&:empty?)
  check = check.split(',').map(&:to_i)

  mapping = mapping.reduce([]){ |acc, str|
    if str.each_char.all?{|c| c == "#"}
      check.delete_at(check.index{|i| i == str.length } || check.length)
    else
      acc << str
    end
    acc
  }

  splits = [mapping]
  if mapping.length != check.length
    splits = []
  end

  sum + splits.reduce(0) {|split_acc, split|
    split_acc + mapping.each_with_index.reduce(1) {|group_acc, (group, i)|
      take = check[i]

      if group.include?('#')
        left_index = group.index('#')
        right_index = group.rindex('#')
        remnant = take - (right_index - left_index + 1)
        if remnant == 0
          group = '?'
        else
          group = '?'*([remnant,left_index].min) + '?'*([remnant,group.length-right_index-1].min)
          take = remnant
        end
      end

      elements = group.length
      count = factorial(elements) / (factorial(take) * factorial(elements - take))

      group_acc * count
    }
  }
}
