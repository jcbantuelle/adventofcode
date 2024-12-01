require 'pp'

class Directory
  attr_accessor :dir_name, :files, :parent, :children

  def initialize(dir_name, parent)
    @dir_name = dir_name
    @parent = parent
    @files = {}
    @children = {}
  end

  def size
    (@children.values.map(&:size).inject(:+) || 0) + (@files.values.inject(:+) || 0)
  end

  def directory_tree
    [self] + @children.values.map(&:directory_tree).flatten
  end
end

root = Directory.new('/', nil)
current_directory = nil

File.open('input.txt').each_line do |line|
  command = line.chomp.split(' ')
  if command[0] == '$'
    if command[1] == 'cd'
      if command[2] == '/'
        current_directory = root
      elsif command[2] == '..'
        current_directory = current_directory.parent || root
      else
        current_directory = current_directory.children[command[2]]
      end
    end
  else
    if command[0] == 'dir'
      unless current_directory.children[command[1]]
        child = Directory.new(command[1], current_directory)
        current_directory.children[command[1]] = child
      end
    else
      unless current_directory.files[command[1]]
        current_directory.files[command[1]] = command[0].to_i
      end
    end
  end
end

pp root.directory_tree.map(&:size).select{|dir| dir <= 100000}.inject(:+)
