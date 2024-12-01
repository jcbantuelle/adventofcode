require 'pp'

class Monkey

  attr_accessor :items, :inspections

  def initialize(items, operation, test_mod, true_monkey, false_monkey)
    @items = items
    @operation = operation
    @test_mod = test_mod
    @true_monkey = true_monkey
    @false_monkey = false_monkey
    @inspections = 0
  end

  def inspect_items
    while !@items.empty?
      @inspections += 1
      item = @operation.call(@items.shift) / 3
      if item % @test_mod == 0
        $monkeys[@true_monkey].items << item
      else
        $monkeys[@false_monkey].items << item
      end
    end
  end
end

# $monkeys = [
#   Monkey.new([79, 98], ->(old){old * 19}, 23, 2, 3),
#   Monkey.new([54, 65, 75, 74], ->(old){old + 6}, 19, 2, 0),
#   Monkey.new([79, 60, 97], ->(old){old * old}, 13, 1, 3),
#   Monkey.new([74], ->(old){old + 3}, 17, 0, 1)
# ]

$monkeys = [
  Monkey.new([65, 78], ->(old){old * 3}, 5, 2, 3),
  Monkey.new([54, 78, 86, 79, 73, 64, 85, 88], ->(old){old + 8}, 11, 4, 7),
  Monkey.new([69, 97, 77, 88, 87], ->(old){old + 2}, 2, 5, 3),
  Monkey.new([99], ->(old){old + 4}, 13, 1, 5),
  Monkey.new([60, 57, 52], ->(old){old * 19}, 7, 7, 6),
  Monkey.new([91, 82, 85, 73, 84, 53], ->(old){old + 5}, 3, 4, 1),
  Monkey.new([88, 74, 68, 56], ->(old){old * old}, 17, 0, 2),
  Monkey.new([54, 82, 72, 71, 53, 99, 67], ->(old){old + 1}, 19, 6, 0)
]

20.times do
  $monkeys.each do |monkey|
    monkey.inspect_items
  end
end

pp $monkeys.map(&:inspections).sort.reverse.take(2).inject(&:*)
