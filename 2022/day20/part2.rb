require 'pp'

counter = -1
modifier = 811589153

# run = ['test.txt', 6]
run = ['input.txt', 4999]
inputs = File.open(run[0]).each_line.map{ |line|
  counter += 1
  value = line.chomp.to_i * modifier
  adjusted_modifier = (value.abs / run[1]) * run[1]
  shift = 0
  if value < 0
    shift = value + adjusted_modifier
  elsif value > 0
    shift = value - adjusted_modifier
  end
  [value, counter, shift]
}

start = Time.now
10.times do |t|
  0.upto(inputs.length-1) do |num_index|
    move_index = inputs.find_index{|i| i[1] == num_index}
    move_value = inputs.delete_at(move_index)
    if move_value[2] < 0
      move_index = inputs.length if move_index == 0
      move_value[2].abs.times do |i|
        move_index -= 1
        move_index = inputs.length if move_index == 0
      end
    elsif move_value[2] > 0
      move_value[2].times do |i|
        move_index += 1
        move_index = 1 if move_index == inputs.length + 1
      end
    end
    inputs.insert(move_index, move_value)
  end
end

coordinates = []
first_index = (inputs.find_index{|i| i[0] == 0} + 1000) % inputs.length
coordinates << inputs[first_index][0]
second_index = (first_index + 1000) % inputs.length
coordinates << inputs[second_index][0]
third_index = (second_index + 1000) % inputs.length
coordinates << inputs[third_index][0]
pp coordinates.inject(&:+)
pp "Finished in: #{Time.now - start}s"
