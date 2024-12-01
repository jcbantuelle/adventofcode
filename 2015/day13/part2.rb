require 'pp'

preferences = []

File.foreach('input.txt') do |line|
  preference = line.chomp.match(/^([A-Za-z]+)\s.+\s([A-Za-z]+)\s(\d+).+\s([A-Za-z]*)\.$/)
  preferences.push({
    person: preference[1],
    neighbor: preference[4],
    happiness: preference[3].to_i * (preference[2] == 'gain' ? 1 : -1)
  })
end

guests = preferences.map{|preference| preference[:person] }.uniq
guests.each do |guest|
  preferences.push({
    person: 'You',
    neighbor: guest,
    happiness: 0
  })
  preferences.push({
    person: guest,
    neighbor: 'You',
    happiness: 0
  })
end
seating_arrangements = preferences.map{|preference| preference[:person] }.uniq.permutation.to_a

pp seating_arrangements.map { |arrangement|
  net_happiness = 0
  arrangement.each_with_index { |seat, index|
    left_index = index == 0 ? arrangement.length - 1 : index - 1
    right_index = index == arrangement.length - 1 ? 0 : index + 1
    left_preference = preferences.find{|preference|
      preference[:person] == seat && preference[:neighbor] == arrangement[left_index]
    }[:happiness]
    right_preference = preferences.find{|preference|
      preference[:person] == seat && preference[:neighbor] == arrangement[right_index]
    }[:happiness]
    net_happiness += left_preference + right_preference
  }
  net_happiness
}.sort.last
