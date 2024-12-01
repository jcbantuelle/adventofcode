require 'pp'

bots = {}
File.foreach('input.txt') do |line|
  direction = line.chomp
  if direction.include?('value')
    details = direction.match(/(\d+)[^\d]*(\d+)/)
    bots[details[2]] = {
      id: details[2],
      low: nil,
      high: nil,
      chips: []
    } if bots[details[2]].nil?
    bots[details[2]][:chips].push(details[1].to_i)
  else
    details = direction.match(/(\d+)[^\d]*\s([a-z]*)\s(\d+)[^\d]*\s([a-z]*)\s(\d+)/)
    bots[details[1]] = {
      id: details[1],
      low: nil,
      high: nil,
      chips: []
    } if bots[details[1]].nil?
    bots[details[1]][:low] = [details[2], details[3]]
    bots[details[1]][:high] = [details[4], details[5]]
  end
end

outputs = {}

while outputs['0'].nil? || outputs['1'].nil? || outputs['2'].nil? do
  next_bot = bots.find{|id, bot|
    bot[:chips].length == 2
  }[1]
  sources = {
    low: next_bot[:chips].min,
    high: next_bot[:chips].max
  }
  next_bot[:chips] = []
  [:low, :high].each do |destination|
    if next_bot[destination][0] == 'output'
      outputs[next_bot[destination][1]] = sources[destination]
    elsif next_bot[destination][0] == 'bot'
      bots[next_bot[destination][1]][:chips].push(sources[destination])
    end
  end
end

pp outputs['0']*outputs['1']*outputs['2']
