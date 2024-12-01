require 'pp'

layers = []
scanners = {}

File.foreach('input.txt') do |line|
  scanner = line.chomp.split(':').map(&:to_i)
  scanners[scanner[0]] = scanner[1]
end

scanner_locations = scanners.keys
max_bound = scanner_locations.max

0.upto(max_bound) do |i|
  layers[i] = {
    depth: scanner_locations.include?(i) ? scanners[i] : 0,
    scanner_pos: 0,
    scanner_dir: 1
  }
end

severity = 0
0.upto(max_bound) do |i|
  severity += (i * layers[i][:depth]) if layers[i][:scanner_pos] == 0 && layers[i][:depth] != 0
  0.upto(max_bound) do |j|
    layers[j][:scanner_pos] += layers[j][:scanner_dir]
    if layers[j][:scanner_pos] == 0
      layers[j][:scanner_dir] = 1
    elsif layers[j][:scanner_pos] == layers[j][:depth] - 1
      layers[j][:scanner_dir] = -1
    end
  end
end

pp severity
