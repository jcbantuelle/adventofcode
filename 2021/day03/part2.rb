require 'pp'

def digit_tally(numbers, index)
  tally = [0,0]
  numbers.each do |number|
    tally[number[index].to_i] += 1
  end
  tally
end

oxygen = []
co2 = []

File.foreach('input.txt') do |line|
  oxygen.push(line.chomp)
  co2.push(line.chomp)
end

0.upto(11) do |index|
  oxygen_tally = digit_tally(oxygen, index)
  co2_tally = digit_tally(co2, index)
  oxygen_keep = oxygen_tally[0] > oxygen_tally[1] ? '0' : '1'
  co2_keep = co2_tally[1] < co2_tally[0] ? '1' : '0'
  oxygen.select!{|number|
    number[index] == oxygen_keep
  }
  if co2.length > 1
    co2.select!{|number|
      number[index] == co2_keep
    }
  end
end

pp oxygen[0].to_i(2) * co2[0].to_i(2)
