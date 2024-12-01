require 'pp'

class Coordinate
  attr_accessor :x, :y, :z

  def initialize(coords)
    @x, @y, @z = coords[3..-2].split(',').map(&:to_i)
  end

  def distance
    x.abs + y.abs + z.abs
  end
end

class Particle
  attr_accessor :position, :velocity, :acceleration

  def initialize(particle)
    @position = Coordinate.new(particle[0])
    @velocity = Coordinate.new(particle[1])
    @acceleration = Coordinate.new(particle[2])
  end
end

particles = []

File.foreach('input.txt') do |line|
  particles.push(Particle.new(line.chomp.split(', ')))
end

closest = [50000000, 0]
particles.each_with_index do |particle, index|
  acceleration_distance = particle.acceleration.distance
  closest = [acceleration_distance, index] if acceleration_distance < closest[0]
end

pp closest
