require 'pp'

$card_values = {
  '2' => 1,
  '3' => 2,
  '4' => 3,
  '5' => 4,
  '6' => 5,
  '7' => 6,
  '8' => 7,
  '9' => 8,
  'T' => 9,
  'J' => 10,
  'Q' => 11,
  'K' => 12,
  'A' => 13,
}

def score(hand)
  card_points = hand.each_char.map{|card| $card_values[card]}
  cards = hand.each_char.sort
  if cards.all?{|card| card == cards[0]}
    card_points.unshift(7)
  elsif cards[0..3].all?{|card| card == cards[0]} || cards[1..4].all?{|card| card == cards[1]}
    card_points.unshift(6)
  elsif (cards[0] == cards[1] && cards[2] == cards[3] && cards[3] == cards[4]) || (cards[0] == cards[1] && cards[1] == cards[2] && cards[3] == cards[4])
    card_points.unshift(5)
  elsif (cards[0] == cards[1] && cards[1] == cards[2]) || (cards[1] == cards[2] && cards[2] == cards[3]) || (cards[2] == cards[3] && cards[3] == cards[4])
    card_points.unshift(4)
  elsif (cards[0] == cards[1] && (cards[2] == cards[3] || cards[3] == cards[4])) || (cards[1] == cards[2] && cards[3] == cards[4])
    card_points.unshift(3)
  elsif cards[0] == cards[1] || cards[1] == cards[2] || cards[2] == cards[3] || cards[3] == cards[4]
    card_points.unshift(2)
  else
    card_points.unshift(1)
  end
  card_points
end

hands = File.open('input.txt').each_line.map(&:chomp).map{|line| line.split(' ')}.map{|hand| [hand[0], hand[1].to_i]}

pp hands.map{|hand, bid|
  [hand, bid, score(hand)]
}.sort{|h1,h2|
  a = h1[2]
  b = h2[2]
  if a[0] == b[0]
    if a[1] == b[1]
      if a[2] == b[2]
        if a[3] == b[3]
          if a[4] == b[4]
            a[5] <=> b[5]
          else
            a[4] <=> b[4]
          end
        else
          a[3] <=> b[3]
        end
      else
        a[2] <=> b[2]
      end
    else
      a[1] <=> b[1]
    end
  else
    a[0] <=> b[0]
  end
}.map{|hand| hand[1]}.each_with_index.to_a.inject(0){|sum, bid|
  sum + (bid[0] * (bid[1]+1))
}
