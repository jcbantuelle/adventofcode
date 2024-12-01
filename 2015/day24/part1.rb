require 'pp'

$solutions = []
$smallest = 1000
$seen = {}

def find_solutions(presents, remaining)
  return if presents.length > $smallest
  left = remaining - presents
  left.each do |present|
    new_presents = presents.dup
    new_presents.push(present).sort!
    memo = new_presents.join(',')
    if $seen[memo].nil?
      $seen[memo] = true
      weight = new_presents.inject(&:+)
      if weight == $target_weight
        $smallest = new_presents.length if new_presents.length < $smallest
        $solutions.push(new_presents)
      elsif weight < $target_weight
        find_solutions(new_presents, remaining-[present])
      end
    end
  end
end

def find_balance(presents, remaining)
  return if $found_balance
  left = remaining - presents
  left.each do |present|
    new_presents = presents.dup
    new_presents.push(present).sort!
    memo = new_presents.join(',')
    if $seen[memo].nil?
      $seen[memo] = true
      weight = new_presents.inject(&:+)
      if weight == $target_weight
        $found_balance = true
      elsif weight < $target_weight
        find_balance(new_presents, remaining-[present])
      end
    end
  end
end

presents = []

File.foreach('input.txt') do |line|
  presents.push(line.chomp.to_i)
end

presents.reverse!
$target_weight = presents.inject(&:+) / 3

# Calculated once, then stored results in smallest_three.txt
# find_solutions([], presents)
# pp $solutions

smallest = []

File.foreach('smallest_three.txt') do |line|
  smallest.push(line.chomp.split(', ').map(&:to_i))
end

smallest.sort_by!{|group| group.inject(&:*)}.each do |group|
  $found_balance = false
  find_balance([], presents-group)
  if $found_balance
    pp group.inject(&:*)
    exit
  end
end
