ranges = []
valid_ids = 0
parsing_ranges = true
File.open('input.txt').map(&:chomp).each { |row|
  if row.empty?
    parsing_ranges = false
  elsif parsing_ranges
    ids = row.split('-').map(&:to_i)
    ranges << (ids[0]..ids[1])
  else
    valid_ids += 1 if ranges.any? { |range| range.include?(row.to_i)}
  end
}

puts valid_ids
