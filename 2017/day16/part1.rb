require 'pp'

programs = ('a'..'p').to_a
program_count = programs.length

File.foreach('input.txt') do |line|
  line.chomp.split(',').each do |step|
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
