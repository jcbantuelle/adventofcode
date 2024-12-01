require 'pp'

class Registers

  attr_accessor :registers, :ip, :ip_register

  def initialize(ip_register)
    @registers = [0,0,0,0,0,0]
    @ip_register = ip_register
    @ip = 0
  end

  def update_ip_register
    @registers[@ip_register] = @ip
  end

  def update_ip
    @ip = @registers[@ip_register] + 1
  end

  def addr(operation)
    @registers[operation[2]] = @registers[operation[0]] + @registers[operation[1]]
  end

  def addi(operation)
    @registers[operation[2]] = @registers[operation[0]] + operation[1]
  end

  def mulr(operation)
    @registers[operation[2]] = @registers[operation[0]] * @registers[operation[1]]
  end

  def muli(operation)
    @registers[operation[2]] = @registers[operation[0]] * operation[1]
  end

  def banr(operation)
    @registers[operation[2]] = @registers[operation[0]] & @registers[operation[1]]
  end

  def bani(operation)
    @registers[operation[2]] = @registers[operation[0]] & operation[1]
  end

  def borr(operation)
    @registers[operation[2]] = @registers[operation[0]] | @registers[operation[1]]
  end

  def bori(operation)
    @registers[operation[2]] = @registers[operation[0]] | operation[1]
  end

  def setr(operation)
    @registers[operation[2]] = @registers[operation[0]]
  end

  def seti(operation)
    @registers[operation[2]] = operation[0]
  end

  def gtir(operation)
    @registers[operation[2]] = operation[0] > @registers[operation[1]] ? 1 : 0
  end

  def gtri(operation)
    @registers[operation[2]] = @registers[operation[0]] > operation[1] ? 1 : 0
  end

  def gtrr(operation)
    @registers[operation[2]] = @registers[operation[0]] > @registers[operation[1]] ? 1 : 0
  end

  def eqir(operation)
    @registers[operation[2]] = operation[0] == @registers[operation[1]] ? 1 : 0
  end

  def eqri(operation)
    @registers[operation[2]] = @registers[operation[0]] == operation[1] ? 1 : 0
  end

  def eqrr(operation)
    @registers[operation[2]] = @registers[operation[0]] == @registers[operation[1]] ? 1 : 0
  end

end

instructions = []
ip_register = nil
File.foreach('input.txt') do |line|
  if ip_register.nil?
    ip_register = line.chomp.split(' ')[1].to_i
  else
    instruction = line.chomp.split(' ')
    instructions << [instruction[0], instruction[1].to_i, instruction[2].to_i, instruction[3].to_i]
  end
end

r = Registers.new(ip_register)
loop do
  break if r.ip < 0 || r.ip >= instructions.length
  r.update_ip_register
  instruction = instructions[r.ip]
  r.send(instruction[0], instruction[1..3])
  r.update_ip
end

pp r.registers[0]
