require 'pp'

class Elf
  attr_accessor :x, :y, :consider

  def initialize(x, y)
    @x = x
    @y = y
  end

  def decide
    return unless has_neighbor?
    $directions.each do |direction|
      if direction == 'N'
        unless $elves["#{x-1},#{y-1}"] || $elves["#{x},#{y-1}"] || $elves["#{x+1},#{y-1}"]
          @consider = [x,y-1]
          break
        end
      elsif direction == 'S'
        unless $elves["#{x-1},#{y+1}"] || $elves["#{x},#{y+1}"] || $elves["#{x+1},#{y+1}"]
          @consider = [x,y+1]
          break
        end
      elsif direction == 'W'
        unless $elves["#{x-1},#{y-1}"] || $elves["#{x-1},#{y}"] || $elves["#{x-1},#{y+1}"]
          @consider = [x-1,y]
          break
        end
      elsif direction == 'E'
        unless $elves["#{x+1},#{y-1}"] || $elves["#{x+1},#{y}"] || $elves["#{x+1},#{y+1}"]
          @consider = [x+1,y]
          break
        end
      end
    end
    unless @consider.nil?
      $consider[@consider.join(',')] ||= 0
      $consider[@consider.join(',')] += 1
    end
  end

  def move
    unless @consider.nil? || $consider[@consider.join(',')] > 1
      @x = @consider[0]
      @y = @consider[1]
    end
    @consider = nil
  end

  def has_neighbor?
    [
      [x-1,y-1],
      [x,y-1],
      [x+1,y-1],
      [x-1,y],
      [x+1,y],
      [x-1,y+1],
      [x,y+1],
      [x+1,y+1]
    ].any?{|coords| !$elves["#{coords[0]},#{coords[1]}"].nil?}
  end

  def to_s
    "#{x},#{y}"
  end
end

$elves = {}
$directions = %w(N S W E)

inputs = File.open('input.txt').each_line.to_a.each_with_index{ |line, y|
  line.chomp.chars.each_with_index do |cell, x|
    if cell == '#'
      elf = Elf.new(x, y)
      $elves[elf.to_s] = elf
    end
  end
}

start = Time.now
10.times do
  $consider = {}
  $new_elves = {}
  $elves.each do |_, elf|
    elf.decide
  end
  $elves.each do |_, elf|
    elf.move
    $new_elves[elf.to_s] = elf
  end
  $elves = $new_elves
  $directions.rotate!
end

x_values = $elves.values.map(&:x)
y_values = $elves.values.map(&:y)

pp (x_values.max - x_values.min + 1) * (y_values.max - y_values.min + 1) - $elves.length

pp "Finished in: #{Time.now - start}s"
