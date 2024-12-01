require 'pp'

class Coordinate
  attr_accessor :x, :y, :z

  def initialize(coords)
    @x, @y, @z = coords[3..-2].split(',').map(&:to_i)
  end
end

class Particle
  attr_accessor :position, :velocity, :acceleration

  def initialize(particle)
    @position = Coordinate.new(particle[0])
    @velocity = Coordinate.new(particle[1])
    @acceleration = Coordinate.new(particle[2])
  end

  def update
    @velocity.x += @acceleration.x
    @velocity.y += @acceleration.y
    @velocity.z += @acceleration.z

    @position.x += @velocity.x
    @position.y += @velocity.y
    @position.z += @velocity.z
  end

  def to_s
    "#{@position.x}-#{@position.y}-#{@position.z}"
  end
end

particles = []

File.foreach('input.txt') do |line|
  particles.push(Particle.new(line.chomp.split(', ')))
end

1_000.times do |i|
  positions = {}
  particles.each_with_index do |particle|
    particle.update
    key = particle.to_s
    positions[key] = [] if positions[key].nil?
    positions[key].push(particle)
  end
  particles = positions.values.reject{|p| p.length > 1}.flatten
end

pp particles.length
