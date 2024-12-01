require 'pp'

crabs = nil

File.foreach('input.txt') do |line|
  crabs = line.chomp.split(',').map(&:to_i)
  break
end

min, max = crabs.minmax
least_fuel = nil
min.upto(max) do |position|
  fuel = crabs.map{|crab| (crab-position).abs }.inject(&:+)
  least_fuel = fuel if least_fuel.nil? || least_fuel > fuel
end

pp least_fuel
