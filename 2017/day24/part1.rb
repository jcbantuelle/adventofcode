require 'pp'

def find_max_strength(connector, strength, ports)
  matches = []
  ports.each_with_index do |port, index|
    if port[0] == connector || port[1] == connector
      remaining_port = port[0] == connector ? port[1] : port[0]
      matches << [remaining_port, port[2], index]
    end
  end
  if matches.count == 0
    $max_strength = strength if strength > $max_strength
  else
    matches.each do |match|
      remaining_ports = ports[0, match[2]].concat(ports[match[2]+1..-1])
      find_max_strength(match[0], strength + match[1], remaining_ports)
    end
  end
end

ports = []
$max_strength = 0

File.foreach('input.txt') do |line|
  port = line.chomp.split('/').map(&:to_i)
  port << port[0] + port[1]
  ports.push(port)
end

find_max_strength(0, 0, ports)
pp $max_strength
