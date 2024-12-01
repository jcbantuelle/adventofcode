require 'pp'

def parse_chunk(chunk)
  chunk.split('>')[0].split(',').map(&:to_i)
end

class Point
  attr_accessor :x, :y, :velocity_x, :velocity_y

  def initialize(point, velocity)
    @x = point[0]
    @y = point[1]
    @velocity_x = velocity[0]
    @velocity_y = velocity[1]
  end

  def move
    @x += @velocity_x
    @y += @velocity_y
  end
end

class Grid
  attr_accessor :points, :min_x, :min_y, :max_x, :max_y

  def initialize
    @points = []
    reset_bounds
  end

  def add_point(coords, velocity)
    point = Point.new(coords, velocity)
    @points << point
    update_bounds(point)
  end

  def update_bounds(point)
    @min_x = point.x if @min_x.nil? || point.x < @min_x
    @min_y = point.y if @min_y.nil? || point.y < @min_y
    @max_x = point.x if @max_x.nil? || point.x > @max_x
    @max_y = point.y if @max_y.nil? || point.y > @max_y
  end

  def reset_bounds
    @max_x = nil
    @max_y = nil
    @min_x = nil
    @min_y = nil
  end

  def normalize
    x_adjustment = 0 - min_x
    y_adjustment = 0 - min_y
    reset_bounds
    @points.each do |point|
      point.x += x_adjustment
      point.y += y_adjustment
      update_bounds(point)
    end
  end

  def render(i)
    if @max_x < 70 && @max_y < 70
      puts i
      exit
    else
      reset_bounds
      @points.each do |point|
        point.move
        update_bounds(point)
      end
    end
  end

end

grid = Grid.new

File.foreach('input.txt') do |line|
  chunks = line.chomp.split('<')
  coords = parse_chunk(chunks[1])
  velocity = parse_chunk(chunks[2])
  grid.add_point(coords, velocity)
end

i = 0
loop do
  grid.normalize
  grid.render(i)
  i += 1
end
