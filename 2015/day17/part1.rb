require 'pp'

containers = []

File.foreach('input.txt') do |line|
  containers.push(line.chomp.to_i)
end

target = 150
valid_combinations = 0
containers.sort!

1.upto(containers.length) do |i|
  smallest = containers[0..(i-1)].inject(&:+)
  largest = containers[-i..-1].inject(&:+)
  if smallest > target || largest < target
    next
  else
    containers.combination(i).each do |container_set|
      valid_combinations += 1 if container_set.inject(&:+) == target
    end
  end
end

pp valid_combinations
