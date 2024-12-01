require 'pp'

fishies = nil

File.foreach('input.txt') do |line|
  fishies = line.chomp.split(',').map(&:to_i)
  break
end

80.times do |i|
  fish_to_add = 0
  fishies = fishies.map{|fish|
    new_value = fish-1
    if new_value == -1
      new_value = 6
      fish_to_add += 1
    end
    new_value
  }
  if fish_to_add > 0
    new_fishies = Array.new(fish_to_add, 8)
    fishies += new_fishies
  end
end

pp fishies.length
