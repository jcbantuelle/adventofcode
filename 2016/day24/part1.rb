require 'pp'

$seen = {}
$grid = []
$numbers = []
$seen_groups = {}

class Node
  attr_accessor :x, :y, :found, :steps, :valid

  def initialize(x, y, found, steps)
    @x = x
    @y = y
    @found = found.dup
    @steps = steps+1
    @cell = $grid[y][x]
    @valid = valid?
    mark_seen
    if @cell.match(/\d/) && !found.include?(@cell)
      @found.push(@cell)
      @found.sort!
      @valid = false if subset?
      $seen_groups[@found.join('')] = @steps if @valid
      if @found == $numbers
        pp @steps
        exit
      end
    end
  end

  def valid?
    !(@cell == '#') && !seen?
  end

  def subset?
    $seen_groups.any? do |group, steps|
      steps < @steps && (@found - group.each_char.to_a).empty?
    end
  end

  def mark_seen
    $seen[found_key] = {} if $seen[found_key].nil?
    $seen[found_key][coords_key] = true
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
      paths.push(Node.new(x, y, ['0'], -1))
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
      cell = Node.new(path.x+offset, path.y, path.found, path.steps)
      new_paths.push(cell) if cell.valid
      cell = Node.new(path.x, path.y+offset, path.found, path.steps)
      new_paths.push(cell) if cell.valid
    end
  end
  paths = new_paths
end
