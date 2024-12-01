require 'pp'

# input.txt
# Looping every 1695 rocks. First part loops starting at 313th rock
# Height at 312 is 490
# Height at 2007 (+1695) is 3124
# Height at 3702 (+1695) should be 5758 (3124 + 2634)

pp 490 + (589970501 * 2634) + (1250 - 490)
exit

# test.txt
# Looping every 35 rocks. First part loops starting at 16th rock
# Height at 15 is 25
# Height at 50 (+35) is 78
# Height at 85 (+35) should be 131 (78 + 53)

# pp 28571428571 * 53 + 25
# exit

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
last_max = 0
# compare_length = 10
# compare_start = 311
# compare_end = compare_start + compare_length + 1
# last = Array.new(compare_length, 0)
# compare = Array.new(compare_length, 0)

start = Time.now
rocks = 0

while rocks < 1_000_000_000_000
  shape = nil
  rock = rocks % 5
  case rock
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
  last_max = max
  max = $chamber.keys.max

  # if rocks > compare_start && rocks < compare_end
  #   compare.shift
  #   compare.push(max - last_max)
  # elsif rocks >= compare_end
  #   last.shift
  #   last.push(max - last_max)
  #   if last == compare
  #     pp rocks
  #     exit
  #   end
  # end
  # if rocks == 311 + 493
  #   pp max
  #   exit
  # end
  rocks += 1
end

pp max
pp "Finished in: #{Time.now - start}s"
