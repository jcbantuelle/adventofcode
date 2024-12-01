require 'pp'

$memo = {}
$total_memo = 0

def fish_count(fish, days_left)
  unless $memo["#{fish}-#{days_left}"].nil?
    $total_memo += 1
    return $memo["#{fish}-#{days_left}"]
  end
  first_day_produced = days_left - (fish+1)
  production_days = first_day_produced.step(0,-7).to_a
  fish_produced = production_days.length
  if fish_produced == 0
    $memo["#{fish}-#{days_left}"] = 0
    return 0
  else
    total = fish_produced + production_days.map { |day|
      fish_count(8, day)
    }.inject(&:+)
    $memo["#{fish}-#{days_left}"] = total
    return total
  end
end

fishies = nil
count = 256

File.foreach('input.txt') do |line|
  fishies = line.chomp.split(',').map(&:to_i)
  break
end

pp fishies.map{ |fish|
  fish_count(fish, count)+1
}.inject(&:+)
