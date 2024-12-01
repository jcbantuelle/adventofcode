time, record = File.open('input.txt').each_line.map(&:chomp).map{|line| line.split(':')[1].strip.gsub(' ', '').to_i }

wins = 0
1.upto(time-1) do |hold|
  distance = (time-hold) * hold
  wins += 1 if distance > record
end

puts wins
