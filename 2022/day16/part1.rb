require 'pp'

class Volcano
  attr_accessor :location, :minutes, :pressure, :pressure_rate, :visited, :unvisited

  def initialize(location, minutes, pressure, pressure_rate, visited, unvisited)
    @location = location
    @minutes = minutes
    @pressure = pressure
    @pressure_rate = pressure_rate
    @visited = visited
    @unvisited = unvisited
  end

  def walk
    volcanos = []
    seen = $seen[seen_index]
    if seen.nil? || seen < pressure_release
      $seen[seen_index] = pressure_release
      current_valve = $valves[@location]
      @unvisited.each do |unvisited_valve|
        destination = current_valve.tunnels_with_distance.find{|t| t[0] == unvisited_valve}
        new_minutes = destination[1] + @minutes + 1
        if new_minutes >= 30
          $max_pressure = pressure_release if pressure_release > $max_pressure
        else
          new_pressure = (@pressure_rate * (new_minutes - @minutes)) + @pressure
          new_pressure_rate = @pressure_rate + $valves[destination[0]].flow
          new_unvisted = @unvisited - [destination[0]]
          if new_unvisted.empty?
            new_pressure += ((30 - new_minutes) * new_pressure_rate)
            $max_pressure = new_pressure if new_pressure > $max_pressure
          else
            new_visited = (@visited.clone + [@location]).sort
            volcanos << Volcano.new(destination[0], new_minutes, new_pressure, new_pressure_rate, new_visited, new_unvisted)
          end
        end
      end
    end
    volcanos
  end

  def seen_index
    @visited.join(',')+":#{@location}"
  end

  def pressure_release
    ((30 - @minutes) * @pressure_rate) + @pressure
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

$max_pressure = 0
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

volcanos = [Volcano.new('AA', 0, 0, 0, [], unvisited)]
while !volcanos.empty?
  volcanos += volcanos.pop.walk
end
pp $max_pressure
pp "Finished in: #{Time.now - start}s"
