require 'pp'

$metadata = 0

class Node
  attr_accessor :children, :metadata

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
      $metadata += metadata_value
    end
  end
end

values = nil

File.foreach('input.txt') do |line|
  values = line.chomp.split(' ').map(&:to_i)
  break
end

node = Node.new(values)

pp $metadata
