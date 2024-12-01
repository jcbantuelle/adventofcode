require 'pp'

$expression = []

def ingest_packet(binary)
  version = binary.slice!(0..2)

  packet_type = binary.slice!(0..2).to_i(2)
  if packet_type == 4
    number = ''
    loop do
      chunk = binary.slice!(0..4)
      number += chunk.slice(1..4)
      break if chunk[0] == '0'
    end
    $expression << number.to_i(2)
  else
    start = $expression.length
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
    values = $expression.slice!(start..$expression.length)
    if packet_type == 0
      result = values.inject(:+)
    elsif packet_type == 1
      result = values.inject(:*)
    elsif packet_type == 2
      result = values.min
    elsif packet_type == 3
      result = values.max
    elsif packet_type == 5
      result = values[0] > values[1] ? 1 : 0
    elsif packet_type == 6
      result = values[0] < values[1] ? 1 : 0
    elsif packet_type == 7
      result = values[0] == values[1] ? 1 : 0
    end
    $expression << result
  end
end

binary = nil
File.foreach('input.txt') do |line|
  line = line.chomp
  binary = line.to_i(16).to_s(2)
  offset = line.length * 4 - binary.length
  unless offset == 0
    offset.times do
      binary = '0'+binary
    end
  end
  break
end

ingest_packet(binary)

pp $expression[0]
