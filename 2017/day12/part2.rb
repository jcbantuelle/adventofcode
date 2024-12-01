require 'pp'
require 'set'

pipes = []

File.foreach('input.txt') do |line|
  pipe = Set.new(line.chomp.sub!('<->', ',').split(',').map(&:to_i))
  matching_pipe = pipes.find{|set| !(set & pipe).empty? }
  if matching_pipe.nil?
    pipes.push(pipe)
  else
    matching_pipe.merge(pipe)
  end
end

merge = true
while merge do
  merge = false
  pipes.map(&:dup).each_with_index do |pipe1, i|
    pipes.map(&:dup).each_with_index do |pipe2, j|
      next if i == j
      unless (pipe1 & pipe2).empty?
        pipes[i].merge(pipe2)
        pipes.delete_at(j)
        merge = true
        break
      end
    end
    break if merge
  end
end

pp pipes.length
