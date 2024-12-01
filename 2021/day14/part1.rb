require 'pp'

conversions = {}
polymer = nil

File.foreach('input.txt') do |line|
  line = line.chomp
  if line.include?('-')
    conversion = line.split(' -> ')
    conversions[conversion[0]] = conversion[1]
  elsif !line.empty?
    polymer = line
  end
end

start = Time.now
10.times do
  new_polymer = polymer.dup
  polymer_offset = 0
  polymer.each_char.to_a.each_with_index do |_, i|
    unless polymer[i+1].nil?
      chunk = polymer[i]+polymer[i+1]
      if conversions[chunk]
        chunk_offset = i+polymer_offset
        new_polymer[chunk_offset] = "#{chunk[0]}#{conversions[chunk]}"
        polymer_offset += 1
      end
    end
  end
  polymer = new_polymer
end
pp Time.now-start

tally = polymer.each_char.to_a.group_by{|i| i}.map{|letter, occurrences|
  [letter, occurrences.length]
}.sort_by{|frequency| frequency[1]}

pp tally.last[1] - tally.first[1]
