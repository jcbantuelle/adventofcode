cards = File.open('input.txt').each_line.map(&:chomp).map { |card|
  winners, numbers = card.split(': ')[1].split(' | ').map{|half| half.split(' ').map(&:strip)}
  [numbers.select{|number| winners.include?(number)}.length,1]
}

cards.each_with_index do |card, current|
  card[0].times do |mod|
    cards[current+mod+1][1] += card[1]
  end
end

puts cards.inject(0){|sum, card| sum + card[1]}
