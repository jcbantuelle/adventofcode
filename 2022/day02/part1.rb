class Round

  CHOICE = {
    'X' => 1,
    'Y' => 2,
    'Z' => 3
  }

  OUTCOME = {
    'AX' => 3,
    'AY' => 6,
    'AZ' => 0,
    'BX' => 0,
    'BY' => 3,
    'BZ' => 6,
    'CX' => 6,
    'CY' => 0,
    'CZ' => 3,
  }

  def initialize(round)
    @opponent = round[0]
    @player = round[1]
  end

  def score
    CHOICE[@player] + OUTCOME["#{@opponent}#{@player}"]
  end
end

puts File.open('input.txt').each_line.map { |round|
  Round.new(round.chomp.split(' ')).score
}.inject(&:+)
