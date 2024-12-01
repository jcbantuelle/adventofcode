require 'pp'

class Volcano
  attr_accessor :locations, :minutes, :pressure, :pressure_rate, :visited, :unvisited

  def initialize(locations, pressure, pressure_rate, visited, unvisited)
    @locations = locations
    @pressure = pressure
    @pressure_rate = pressure_rate
    @visited = visited
    @unvisited = unvisited
  end

  def walk(minutes)
    @pressure += @pressure_rate
    volcanos = process_arrival(0, minutes)
    if !volcanos.empty?
      location = @locations[1]
      volcanos = volcanos.map{|volcano| volcano.process_arrival(1, minutes)}.flatten
    end
    volcanos
  end

  def process_arrival(location_index, minutes)
    location = @locations[location_index]
    volcanos = []
    if location[1] == minutes
      current_valve = $valves[location[0]]
      @pressure_rate += current_valve.flow
      @pressure += current_valve.flow
      pressure_at_end = pressure_release(minutes)
      seen = $seen[seen_index]
      if seen.nil? || seen < pressure_at_end
        $seen[seen_index] = pressure_at_end
        if @unvisited.empty?
          @locations = location_index == 0 ?
              [['',0], @locations[1]] :
              [@locations[0],['',0]]
          volcanos = [self]
        else
          @unvisited.each do |unvisited_valve|
            destination = current_valve.tunnels_with_distance.find{|t| t[0] == unvisited_valve}
            new_visited = (@visited.clone + [location[0]]).sort
            new_unvisted = @unvisited - [destination[0]]
            new_destination = [destination[0], minutes + destination[1] + 1]
            new_location = location_index == 0 ?
              [new_destination, @locations[1]] :
              [@locations[0],new_destination]
            volcanos << Volcano.new(new_location, @pressure, @pressure_rate, new_visited, new_unvisted)
          end
        end
      end
    else
      volcanos = [self]
    end
    volcanos
  end

  def seen_index
    @visited.join(',')+":#{[@locations[0][0], @locations[1][0]].sort.join(',')}"
  end

  def pressure_release(minutes)
    ((30 - minutes) * @pressure_rate) + @pressure
  end
end

class Valve
  attr_accessor :id, :flow, :tunnels, :tunnels_with_distance

  def initialize(id, flow, tunnels)
    @id = id
    @flow = flow
    @tunnels = tunnels.split(', ')
  end

  def build_tunnels_with_distance
    all_tunnels = $valves.keys - ([@id] + [@tunnels])
    @tunnels_with_distance = @tunnels.map{|t| [t, 1]}
    distance = 1
    while !all_tunnels.empty?
      @tunnels_with_distance += (@tunnels_with_distance.select{|t| t[1] == distance}.map{|tunnel|
        $valves[tunnel[0]].tunnels
      }.flatten & all_tunnels).map{|t| [t, distance+1]}
      distance += 1
      all_tunnels -= @tunnels_with_distance.map{|t| t[0]}
    end
    @tunnels_with_distance = @tunnels_with_distance.reject{|t| $valves[t[0]].flow == 0}
  end
end

$seen = {}
$valves = {}

File.open('input.txt').each_line.map(&:chomp).compact.each{ |line|
  valve = /Valve\s(..).*=(\d+).*valve[s]?\s(.*)/.match(line)[1..-1]
  $valves[valve[0]] = Valve.new(valve[0], valve[1].to_i, valve[2])
}

$valves.each do |id, valve|
  valve.build_tunnels_with_distance
end

start = Time.now
unvisited = $valves['AA'].tunnels_with_distance.map{|t| t[0]}

volcanos = [Volcano.new([['AA', 4], ['AA', 4]], 0, 0, [], unvisited)]
4.upto(29) do |minute|
  volcanos = volcanos.map{|volcano|
    volcano.walk(minute)
  }.flatten
end

pp volcanos.map{|v| v.pressure}.max
pp "Finished in: #{Time.now - start}s"
