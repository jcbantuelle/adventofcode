require 'pp'

class Shape
  attr_accessor :coords

  def initialize(coords)
    @coords = coords
  end

  def shift(jet)
    x_mod = jet == '<' ? -1 : +1
    new_coords = coords.map{|point| [point[0]+x_mod, point[1]]}
    @coords = new_coords unless collision(new_coords)
  end

  def drop
    new_coords = coords.map{|point| [point[0], point[1]-1]}
    collide = collision(new_coords)
    if collide
      @coords.each do |point|
        $chamber[point[1]] ||= Array.new(7)
        $chamber[point[1]][point[0]] = true
      end
    else
      @coords = new_coords
    end
    collide
  end

  def collision(new_coords)
    new_coords.any?{|point|
      row = $chamber[point[1]]
      point[0] < 0 || point[0] > 6 || (!row.nil? && !row[point[0]].nil?)
    }
  end
end

jets = File.open('input.txt').each_line.map(&:chomp).first
jet_index = 0
jets_length = jets.length

$chamber = {0 => Array.new(7, true)}
max = 0

start = Time.now
rocks = 0
while rocks < 2022 do
  shape = nil
  case rocks % 5
  when 0
    shape = Shape.new([[2,max+4], [3,max+4], [4,max+4], [5,max+4]])
  when 1
    shape = Shape.new([[2,max+5], [3,max+5], [4,max+5], [3,max+4], [3,max+6]])
  when 2
    shape = Shape.new([[2,max+4], [3,max+4], [4,max+4], [4,max+5], [4,max+6]])
  when 3
    shape = Shape.new([[2,max+4], [2,max+5], [2,max+6], [2,max+7]])
  when 4
    shape = Shape.new([[2,max+4], [2,max+5], [3,max+4], [3,max+5]])
  end
  loop do
    shape.shift(jets[jet_index % jets_length])
    jet_index += 1
    break if shape.drop
  end
  max = $chamber.keys.max
  rocks += 1
end

pp max
pp "Finished in: #{Time.now - start}s"
