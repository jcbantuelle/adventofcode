def page_requirements(page, rules, order)
  rules.select{|p1, p2|
    order.include?(p1) && p2 == page
  }.map{|rule| rule[0]}
end

def valid_order?(order, rules)
  seen = {}
  order.all?{|page|
    seen[page] = true
    page_requirements(page, rules, order).all?{|prior| seen[prior] }
  }
end

def fix_order(order, rules)
  seen = {}
  violation_index = nil
  misplaced_page = order.find_index{|page|
    seen[page] = true
    requirements = page_requirements(page, rules, order)
    offending_page = requirements.find{|requirement| !seen[requirement]}
    violation_index = order.index(offending_page) if offending_page
  }
  unless violation_index.nil?
    order.insert(violation_index,order.delete_at(misplaced_page))
    fix_order(order, rules)
  end
end

file = File.open('input.txt').each_line.map(&:chomp)
split = file.index('')
rules = file[0..split-1].map{|rule| rule.split('|').map(&:to_i)}
invalid_orders = file[split+1..-1].map{|order| order.split(',').map(&:to_i)}.reject{|order| valid_order?(order, rules)}

puts invalid_orders.reduce(0) {|total, order|
  fix_order(order, rules)
  total + order[order.length/2]
}
