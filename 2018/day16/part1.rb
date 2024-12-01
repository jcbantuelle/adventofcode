require 'pp'

class Registers

  TESTS = %w(
    addr
    addi
    mulr
    muli
    banr
    bani
    borr
    bori
    setr
    seti
    gtir
    gtri
    gtrr
    eqir
    eqri
    eqrr
  )

  attr_accessor :matches

  def initialize(before, after, operation)
    @before = before
    @after = after
    @operation = operation
    @matches = []
  end

  def test
    TESTS.each do |t|
      result = send(t, @before.dup)
      @matches << t if result == @after
    end
    @matches
  end

  def addr(registers)
    registers[@operation[3]] = registers[@operation[1]] + registers[@operation[2]]
    registers
  end

  def addi(registers)
    registers[@operation[3]] = registers[@operation[1]] + @operation[2]
    registers
  end

  def mulr(registers)
    registers[@operation[3]] = registers[@operation[1]] * registers[@operation[2]]
    registers
  end

  def muli(registers)
    registers[@operation[3]] = registers[@operation[1]] * @operation[2]
    registers
  end

  def banr(registers)
    registers[@operation[3]] = registers[@operation[1]] & registers[@operation[2]]
    registers
  end

  def bani(registers)
    registers[@operation[3]] = registers[@operation[1]] & @operation[2]
    registers
  end

  def borr(registers)
    registers[@operation[3]] = registers[@operation[1]] | registers[@operation[2]]
    registers
  end

  def bori(registers)
    registers[@operation[3]] = registers[@operation[1]] | @operation[2]
    registers
  end

  def setr(registers)
    registers[@operation[3]] = registers[@operation[1]]
    registers
  end

  def seti(registers)
    registers[@operation[3]] = @operation[1]
    registers
  end

  def gtir(registers)
    registers[@operation[3]] = @operation[1] > registers[@operation[2]] ? 1 : 0
    registers
  end

  def gtri(registers)
    registers[@operation[3]] = registers[@operation[1]] > @operation[2] ? 1 : 0
    registers
  end

  def gtrr(registers)
    registers[@operation[3]] = registers[@operation[1]] > registers[@operation[2]] ? 1 : 0
    registers
  end

  def eqir(registers)
    registers[@operation[3]] = @operation[1] == registers[@operation[2]] ? 1 : 0
    registers
  end

  def eqri(registers)
    registers[@operation[3]] = registers[@operation[1]] == @operation[2] ? 1 : 0
    registers
  end

  def eqrr(registers)
    registers[@operation[3]] = registers[@operation[1]] == registers[@operation[2]] ? 1 : 0
    registers
  end

end

opcodes = {}
16.times do |i|
  opcodes[i] = []
end

before = nil
operation = nil
after = nil

total = 0
File.foreach('opcodes.txt') do |line|
  if before.nil?
    before = line.chomp.split('[')[1][0..-2].split(', ').map(&:to_i)
  elsif operation.nil?
    operation = line.chomp.split(' ').map(&:to_i)
  elsif after.nil?
    after = line.chomp.split('[')[1][0..-2].split(', ').map(&:to_i)

    r = Registers.new(before, after, operation)
    matches = r.test
    opcodes[operation[0]] << matches
    total += 1 if matches.length > 2

    before = nil
    operation = nil
    after = nil
  end
end

pp total
