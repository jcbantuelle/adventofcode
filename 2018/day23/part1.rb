require 'pp'

bots = []
File.open('input.txt').each_line do |line|
  pos = line.chomp.split('=<')[1].split(',')
  pos[2] = pos[2][0..-2]
  pos[3] = pos[3].split('=')[1]
  bots << pos.map(&:to_i)
end

largest_signal = bots.max_by { |bot|
  bot[3]
}

pp bots.select {|bot|
  distance = (bot[0] - largest_signal[0]).abs +
    (bot[1] - largest_signal[1]).abs +
    (bot[2] - largest_signal[2]).abs
  distance <= largest_signal[3]
}.length
