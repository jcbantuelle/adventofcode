require 'pp'

class Tape

  attr_accessor :tape, :state

  def initialize
    @tape = [0]
    @index = 0
    @state = 1
  end

  def action(value, direction, state)
    write(value)
    move(direction)
    @state = state
  end

  def current
    @tape[@index]
  end

  private

  def move(direction)
    if direction == 'r'
      @index += 1
      @tape[@index] = 0 if @tape[@index].nil?
    elsif direction == 'l'
      if @index == 0
        @tape.unshift(0)
      else
        @index -= 1
      end
    end
  end

  def write(value)
    @tape[@index] = value
  end
end

tape = Tape.new

12317297.times do
  if tape.state == 1
    if tape.current == 0
      tape.action(1, 'r', 2)
    else
      tape.action(0, 'l', 4)
    end
  elsif tape.state == 2
    if tape.current == 0
      tape.action(1, 'r', 3)
    else
      tape.action(0, 'r', 6)
    end
  elsif tape.state == 3
    if tape.current == 0
      tape.action(1, 'l', 3)
    else
      tape.action(1, 'l', 1)
    end
  elsif tape.state == 4
    if tape.current == 0
      tape.action(0, 'l', 5)
    else
      tape.action(1, 'r', 1)
    end
  elsif tape.state == 5
    if tape.current == 0
      tape.action(1, 'l', 1)
    else
      tape.action(0, 'r', 2)
    end
  elsif tape.state == 6
    if tape.current == 0
      tape.action(0, 'r', 3)
    else
      tape.action(0, 'r', 5)
    end
  end
end

pp tape.tape.inject(&:+)
