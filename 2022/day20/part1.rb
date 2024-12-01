require 'pp'

counter = -1
inputs = File.open('test.txt').each_line.map{ |line|
  counter += 1
  [line.chomp.to_i, counter]
}
inputs.map{|i|
  index_value = i[0]
  if index_value < 0
    index_value = (index_value * -1) % inputs.length * -1
  else
    index_value = index_value % inputs.length
  end
  i << index_value
}

start = Time.now
inputs.length.times do |num_index|
  move_index = inputs.find_index{|i| i[1] == num_index}
  move_value = inputs.delete_at(move_index)
  if move_value[2] < 0
    move_value[2].abs.times do |i|
      move_index -= 1
      move_index = inputs.length if move_index == 0
    end
  elsif move_value[2] > 0
    move_value[2].abs.times do |i|
      move_index += 1
      move_index = 1 if move_index == inputs.length + 1
    end
  end
  inputs.insert(move_index, move_value)
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
