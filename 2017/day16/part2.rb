require 'pp'

programs = ('a'..'p').to_a
program_count = programs.length
steps = nil

File.foreach('input.txt') do |line|
  steps = line.chomp.split(',')
end

# The dance loops every 60 iterations
# 1_000_000_000 % 60 = 40
# We only need to iterate 40 times to find the answer
40.times do |i|
  steps.each do |step|
    if step[0] == 's'
      spin = step.match(/s(\d*)/)[1].to_i
      programs = programs[-spin..-1] + programs[0..(program_count-spin-1)]
    elsif step[0] == 'x'
      pair = step.match(/x(\d*)\/(\d*)/)
      pos1 = pair[1].to_i
      pos2 = pair[2].to_i
      programs[pos1], programs[pos2] = programs[pos2], programs[pos1]
    elsif step[0] == 'p'
      pos1 = programs.find_index{|prog| prog == step[1]}
      pos2 = programs.find_index{|prog| prog == step[3]}
      programs[pos1], programs[pos2] = programs[pos2], programs[pos1]
    end
  end
end

pp programs.join
