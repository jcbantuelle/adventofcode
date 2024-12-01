require 'pp'

blocks = nil

File.foreach('input.txt') do |line|
  blocks = line.chomp.split(' ').map(&:to_i)
end

steps = 0
memo = {}

while memo[blocks.join('-')].nil?
  memo[blocks.join('-')] = true
  steps += 1
  current_index = blocks.find_index{ |block|
    block == blocks.max
  }
  distribution = blocks[current_index]
  blocks[current_index] = 0
  while distribution > 0 do
    current_index += 1
    current_index = 0 if current_index == blocks.length
    blocks[current_index] += 1
    distribution -= 1
  end
end

pp steps
