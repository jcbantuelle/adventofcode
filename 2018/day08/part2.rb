require 'pp'

class Node
  attr_accessor :children, :metadata, :value

  def initialize(contents)
    @children = []
    @metadata = []
    child_count = contents.shift
    metadata_count = contents.shift
    child_count.times do
      @children << Node.new(contents)
    end
    metadata_count.times do
      metadata_value = contents.shift
      @metadata << metadata_value
    end
    if child_count == 0
      @value = @metadata.inject(&:+)
    else
      @value = @metadata.reduce(0) do |sum, child_node|
        child_index = child_node - 1
        sum += @children[child_index].value unless @children[child_index].nil?
        sum
      end
    end
  end
end

values = nil

File.foreach('input.txt') do |line|
  values = line.chomp.split(' ').map(&:to_i)
  break
end

node = Node.new(values)
pp node.value
