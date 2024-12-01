require 'pp'

x = 1
pp File.open('test.txt').each_line.inject(0) { |sum, line|
  pp x
  mapping, check = line.chomp.split(' ')
  mapping = Array.new(5,mapping).join('?')
  check = check*5
  mapped = mapping.each_char
  check = check.split(',').map(&:to_i)
  total_springs = check.inject(&:+)
  fixed_springs = mapped.select{|s| s == '#'}.length
  springs_to_place = total_springs - fixed_springs
  variables = mapped.select{|s| s == '?'}.length
  fills = ['.','#'].repeated_permutation(variables).to_a.uniq.reject{|fill| fill.select{|f| f == '#'}.length != springs_to_place}
  x += 1
  sum + fills.select{|fill|
    spring = mapping
    fill.each do |f|
      spring = spring.sub('?', f)
    end
    spring = spring.split('.').reject(&:empty?)
    if spring.length == check.length
      spring.zip(check).all?{|a| a[0].length == a[1]}
    else
      false
    end
  }.length
}
