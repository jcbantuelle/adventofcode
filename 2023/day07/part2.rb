$card_values = {
  'J' => 1,
  '2' => 2,
  '3' => 3,
  '4' => 4,
  '5' => 5,
  '6' => 6,
  '7' => 7,
  '8' => 8,
  '9' => 9,
  'T' => 10,
  'Q' => 11,
  'K' => 12,
  'A' => 13,
}

def substitute_joker(hand)
  joker_index = hand.find_index('J')
  if joker_index.nil?
    [hand]
  else
    new_hands = []
    $card_values.keys[1..-1].each do |subtitute|
      new_hand = hand.clone
      new_hand[joker_index] = subtitute
      new_hands += substitute_joker(new_hand)
    end
    new_hands
  end
end

def score(hand)
  card_points = hand.each_char.map{|card| $card_values[card]}
  possible_hands = substitute_joker(hand.each_char.to_a).map(&:sort).uniq

  best_hand = 1
  possible_hands.each do |cards|
    if cards.all?{|card| card == cards[0]}
      best_hand = 7
      break
    elsif best_hand < 6
      if cards[0..3].all?{|card| card == cards[0]} || cards[1..4].all?{|card| card == cards[1]}
        best_hand = 6
      elsif best_hand < 5
        if (cards[0] == cards[1] && cards[2] == cards[3] && cards[3] == cards[4]) || (cards[0] == cards[1] && cards[1] == cards[2] && cards[3] == cards[4])
          best_hand = 5
        elsif best_hand < 4
          if (cards[0] == cards[1] && cards[1] == cards[2]) || (cards[1] == cards[2] && cards[2] == cards[3]) || (cards[2] == cards[3] && cards[3] == cards[4])
            best_hand = 4
          elsif best_hand < 3
            if (cards[0] == cards[1] && (cards[2] == cards[3] || cards[3] == cards[4])) || (cards[1] == cards[2] && cards[3] == cards[4])
              best_hand = 3
            elsif best_hand < 2 && cards[0] == cards[1] || cards[1] == cards[2] || cards[2] == cards[3] || cards[3] == cards[4]
              best_hand = 2
            end
          end
        end
      end
    end
  end
  card_points.unshift(best_hand)
end

hands = File.open('input.txt').each_line.map(&:chomp).map{|line| line.split(' ')}.map{|hand| [hand[0], hand[1].to_i]}

puts hands.map{|hand, bid|
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
