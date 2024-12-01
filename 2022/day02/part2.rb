class Round

  CHOICE = {
    'X' => 1,
    'Y' => 2,
    'Z' => 3
  }

  SELECTION = {
    'AX' => 'Z',
    'AY' => 'X',
    'AZ' => 'Y',
    'BX' => 'X',
    'BY' => 'Y',
    'BZ' => 'Z',
    'CX' => 'Y',
    'CY' => 'Z',
    'CZ' => 'X',
  }

  OUTCOME = {
    'X' => 0,
    'Y' => 3,
    'Z' => 6
  }

  def initialize(round)
    @opponent = round[0]
    @outcome = round[1]
  end

  def score
    CHOICE[selection] + OUTCOME[@outcome]
  end

  private

  def selection
    SELECTION["#{@opponent}#{@outcome}"]
  end
end

puts File.open('input.txt').each_line.map { |round|
  Round.new(round.chomp.split(' ')).score
}.inject(&:+)
