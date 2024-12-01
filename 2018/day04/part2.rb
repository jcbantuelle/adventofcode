require 'pp'

timeline = []

File.foreach('input.txt') do |line|
  event = line.chomp.match(/\[(\d*)\-(\d*)\-(\d*)\s(\d*):(\d*)\]\s(.*)/)
  timeline.push({
    timestamp: event[1]+event[2]+event[3]+event[4]+event[5],
    year: event[1].to_i,
    month: event[2].to_i,
    day: event[3].to_i,
    hour: event[4].to_i,
    minute: event[5].to_i,
    event: event[6]
  })
end

timeline.sort!{ |a,b|
  a[:timestamp] <=> b[:timestamp]
}

guards = {}
guard = nil
sleep_start = nil

timeline.each do |event|
  guard_event = event[:event].match(/Guard\s#(\d*)/)
  if guard_event
    guard = guard_event[1]
  else
    if event[:event] == 'falls asleep'
      sleep_start = event[:minute]
    else
      guards[guard] = Array.new(60,0) if guards[guard].nil?
      sleep_start.upto(event[:minute]-1) do |index|
        guards[guard][index] +=  1
      end
    end
  end
end

guard_array = guards.map do |guard_id, minutes|
  sleepiest_minute = minutes.max
  [guard_id, sleepiest_minute, minutes.find_index(sleepiest_minute)]
end

sleepiest_guard = guard_array.max { |a,b|
  a[1] <=> b[1]
}

pp sleepiest_guard[0].to_i * sleepiest_guard[2]
