require 'pp'

races = File.open('input.txt').each_line.map(&:chomp).map{|line| line.split(':')[1].strip.split(' ').map(&:strip).map(&:to_i)}

wins = []
races[0].each_with_index do |race, i|
  record = races[1][i]
  wins[i] = 0
  1.upto(race-1) do |hold|
    distance = (race-hold) * hold
    wins[i] += 1 if distance > record
  end
end

pp wins.inject(&:*)
