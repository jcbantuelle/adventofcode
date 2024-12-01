require 'pp'

class Cuboid
  attr_reader :min_x, :max_x, :min_y, :max_y, :min_z, :max_z

  def initialize(dimensions)
    @min_x = dimensions[2].to_i
    @max_x = dimensions[3].to_i
    @min_y = dimensions[4].to_i
    @max_y = dimensions[5].to_i
    @min_z = dimensions[6].to_i
    @max_z = dimensions[7].to_i
  end

  def axis_intersects?(cuboid, axis)
    cuboid_min = cuboid.send("min_#{axis}")
    cuboid_max = cuboid.send("max_#{axis}")
    self_min = send("min_#{axis}")
    self_max = send("max_#{axis}")
    cuboid_min.between?(self_min, self_max) ||
    cuboid_max.between?(self_min, self_max) ||
    self_min.between?(cuboid_min, cuboid_max) ||
    self_max.between?(cuboid_min, cuboid_max)
  end

  def intersects?(cuboid)
    axis_intersects?(cuboid, 'x') &&
    axis_intersects?(cuboid, 'y') &&
    axis_intersects?(cuboid, 'z')
  end

  def split(cuboid)
    cuboids = []
    if intersects?(cuboid)
      if max_z > cuboid.max_z
        cuboids.push(Cuboid.new([nil,nil,min_x,max_x,min_y,max_y,cuboid.max_z+1,max_z]))
        @max_z = cuboid.max_z
      end
      if min_z < cuboid.min_z
        cuboids.push(Cuboid.new([nil,nil,min_x,max_x,min_y,max_y,min_z,cuboid.min_z-1]))
        @min_z = cuboid.min_z
      end
      if max_y > cuboid.max_y
        cuboids.push(Cuboid.new([nil,nil,min_x,max_x,cuboid.max_y+1,max_y,min_z,max_z]))
        @max_y = cuboid.max_y
      end
      if min_y < cuboid.min_y
        cuboids.push(Cuboid.new([nil,nil,min_x,max_x,min_y,cuboid.min_y-1,min_z,max_z]))
        @min_y = cuboid.min_y
      end
      if max_x > cuboid.max_x
        cuboids.push(Cuboid.new([nil,nil,cuboid.max_x+1,max_x,min_y,max_y,min_z,max_z]))
        @max_x = cuboid.max_x
      end
      if min_x < cuboid.min_x
        cuboids.push(Cuboid.new([nil,nil,min_x,cuboid.min_x-1,min_y,max_y,min_z,max_z]))
        @min_x = cuboid.min_x
      end
    else
      cuboids.push(self)
    end
    cuboids
  end

  def volume
    (min_x..max_x).size * (min_y..max_y).size * (min_z..max_z).size
  end
end

cuboids = []
start = Time.now
File.foreach('input2.txt') do |line|
  instruction = line.chomp.match(/^([a-z]+)\sx=(\-?\d+)\.\.(\-?\d+),y=(\-?\d+)\.\.(\-?\d+),z=(\-?\d+)\.\.(\-?\d+)$/)
  new_cuboid = Cuboid.new(instruction)
  new_cuboids = []
  while !cuboids.empty?
    cuboid = cuboids.shift
    new_cuboids += cuboid.split(new_cuboid)
  end
  new_cuboids.push(new_cuboid) if instruction[1] == 'on'
  cuboids = new_cuboids
end
pp Time.now - start

pp cuboids.map(&:volume).inject(&:+)
