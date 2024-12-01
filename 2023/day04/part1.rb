puts File.open('input.txt').each_line.map(&:chomp).inject(0) { |sum, card|
  winners, numbers = card.split(': ')[1].split(' | ').map{|half| half.split(' ').map(&:strip)}
  matches = numbers.select{|number| winners.include?(number)}
  sum + (matches.empty? ? 0 : 2**(matches.length-1))
}
