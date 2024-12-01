require 'pp'

$seen = {}
$go_back_seen = {}
$grid = []
$numbers = []
$seen_groups = {}

class Node
  attr_accessor :x, :y, :found, :go_back, :steps, :valid

  def initialize(x, y, found, go_back, steps)
    @x = x
    @y = y
    @steps = steps+1
    @go_back = go_back
    @cell = $grid[y][x]
    if @go_back
      if @cell == '0'
        pp steps+1
        exit
      end
      @valid = go_back_valid?
      mark_go_back_seen
    else
      @found = found.dup
      @valid = valid?
      mark_seen
      if @cell.match(/\d/) && !found.include?(@cell)
        @found.push(@cell)
        @found.sort!
        # @valid = false if subset?
        # $seen_groups[@found.join('')] = @steps if @valid
        @go_back = true if @found == $numbers
      end
    end
  end

  def go_back_valid?
    !(@cell == '#') && !go_back_seen?
  end

  def valid?
    !(@cell == '#') && !seen?
  end

  # def subset?
  #   $seen_groups.any? do |group, steps|
  #     steps < @steps && (@found - group.each_char.to_a).empty?
  #   end
  # end

  def mark_seen
    $seen[found_key] = {} if $seen[found_key].nil?
    $seen[found_key][coords_key] = true
  end

  def mark_go_back_seen
    $go_back_seen[coords_key] = true
  end

  def go_back_seen?
    $go_back_seen[coords_key]
  end

  def seen?
    $seen[found_key] && $seen[found_key][coords_key]
  end

  def found_key
    @found_key ||= @found.join(',')
  end

  def coords_key
    @coords_key ||= "#{@x},#{@y}"
  end
end

File.foreach('input.txt') do |line|
  $grid.push(line.chomp.each_char.to_a)
end

paths = []
$grid.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    if cell == '0'
      paths.push(Node.new(x, y, ['0'], false, -1))
    end
    if cell.match(/\d/)
      $numbers.push(cell)
    end
  end
end
$numbers.sort!

loop do
  new_paths = []
  paths.each do |path|
    [-1,1].each do |offset|
      cell = Node.new(path.x+offset, path.y, path.found, path.go_back, path.steps)
      new_paths.push(cell) if cell.valid
      cell = Node.new(path.x, path.y+offset, path.found, path.go_back, path.steps)
      new_paths.push(cell) if cell.valid
    end
  end
  paths = new_paths
end
