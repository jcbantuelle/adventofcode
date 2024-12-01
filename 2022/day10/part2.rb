require 'pp'

class CRT
  def initialize
    @cycle = 0
    @register = 1
    @crt = []
    6.times do |y|
      @crt[y] = []
      40.times do |x|
        @crt[y] << '.'
      end
    end
  end

  def process(instruction)
    if instruction[0] == 'noop'
      update
    else
      update
      update
      @register += instruction[1].to_i
    end
  end

  def update
    @cycle += 1
    @crt[y][x] = '#' if ((@register-1)..(@register+1)).include?(x)
  end

  def x
    (@cycle - 1) % 40
  end

  def y
    (@cycle - 1) / 40
  end

  def to_s
    @crt.map(&:join)
  end
end

crt = CRT.new
File.open('input.txt').each_line{ |line|
  crt.process(line.chomp.split(' '))
}
pp crt.to_s
