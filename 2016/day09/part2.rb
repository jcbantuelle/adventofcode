require 'pp'

def subcount(segment, multiplier, depth)
  if segment.include?('(')
    # Find the first expansion
    segment_index = segment.index('(')
    segment_match = segment.match(/\((\d*)x(\d*)\)/)

    # Throw away everything up to the end of the expansion
    prefix = segment[0..segment_index+segment_match[0].length-1]
    segment = segment[segment_index+segment_match[0].length..segment.length]

    # Add any letters preceding the expansion to the count
    $count += prefix.length - segment_match[0].length

    # Find the segment affected by the expansion
    expanded_segment = segment[0..segment_match[1].to_i-1]

    # Retrieve the part of the expanded segment that isn't itself an expansion
    real_letters = expanded_segment.gsub(/\(\d*x\d*\)/, '')

    # Retrieve the current segment multiplier
    segment_multiplier = segment_match[2].to_i

    # If this expansion is part of a parent expansion, we need to remove the parent count
    sub_multiplier = segment_multiplier
    sub_multiplier -= 1 unless depth == 1
    sub_multiplier = 1 if sub_multiplier < 1

    # Add expansion occurrences
    expansion_count = real_letters.length * multiplier * sub_multiplier
    $count += real_letters.length * multiplier * sub_multiplier unless depth > 1 && segment_multiplier == 1

    # Expand any subsections further
    subcount(expanded_segment, multiplier * segment_multiplier, depth+1) if expanded_segment.include?('(')

    # Continue expanding original expression
    segment = segment[expanded_segment.length..segment.length]
    subcount(segment, multiplier, depth)
  else
    $count += segment.length
  end
end

compressed = nil
File.foreach('input.txt') do |line|
  compressed = line.chomp
  break
end

$count = 0
subcount(compressed, 1, 1)
pp $count
