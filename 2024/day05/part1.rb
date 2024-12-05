def page_requirements(page, rules, order)
  rules.select{|p1, p2|
    order.include?(p1) && p2 == page
  }.map{|rule| rule[0]}
end

file = File.open('input.txt').each_line.map(&:chomp)
split = file.index('')
rules = file[0..split-1].map{|rule| rule.split('|').map(&:to_i)}
orders = file[split+1..-1].map{|order| order.split(',').map(&:to_i)}

puts orders.reduce(0) { |total, order|
  seen = {}
  valid = order.all?{|page|
    seen[page] = true
    page_requirements(page, rules, order).all?{|prior| seen[prior] }
  }
  total + (valid ? order[order.length/2] : 0)
}
