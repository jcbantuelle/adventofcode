require 'pp'

$version_sum = 0

def ingest_packet(binary)
  version = binary.slice!(0..2)
  $version_sum += version.to_i(2)

  packet_type = binary.slice!(0..2).to_i(2)
  if packet_type == 4
    number = ''
    loop do
      chunk = binary.slice!(0..4)
      number += chunk.slice(1..4)
      break if chunk[0] == '0'
    end
  else
    length_type = binary.slice!(0..0)
    if length_type == '0'
      sub_packets_length = binary.slice!(0..14)
      sub_packets_length = sub_packets_length.to_i(2)
      sub_packets = binary.slice!(0..(sub_packets_length-1))
      loop do
        break if sub_packets.empty?
        ingest_packet(sub_packets)
      end
    elsif length_type == '1'
      sub_packets_count = binary.slice!(0..10)
      sub_packets_count = sub_packets_count.to_i(2)
      sub_packets_count.times do
        ingest_packet(binary)
      end
    end
  end
end

binary = nil
File.foreach('input.txt') do |line|
  binary = line.chomp.to_i(16).to_s(2)
  offset = binary.length % 4
  unless offset == 0
    lpad = ''
    (4-offset).times do
      lpad += '0'
    end
    binary = lpad+binary
  end
  break
end

loop do
  break if binary.empty?
  ingest_packet(binary)
end

pp $version_sum
