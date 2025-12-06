ranges = []
File.open('input.txt').map(&:chomp).each { |row|
  if row.empty?
    break
  else
    ids = row.split('-').map(&:to_i)
    ranges << (ids[0]..ids[1])
  end
}

merges = true
while merges do
  merges = false
  new_ranges = []

  ranges.each do |old_range|
    overlap_index = new_ranges.find_index{|new_range| new_range.include?(old_range.min) || new_range.include?(old_range.max)}
    if overlap_index.nil?
      new_ranges << old_range
    else
      new_range = new_ranges[overlap_index]
      lower = [old_range.min, new_range.min].min
      upper = [old_range.max, new_range.max].max
      new_ranges[overlap_index] = (lower..upper)
      merges = true
    end
  end

  ranges = new_ranges
end

ranges.reverse!
merges = true
while merges do
  merges = false
  new_ranges = []

  ranges.each do |old_range|
    overlap_index = new_ranges.find_index{|new_range| new_range.include?(old_range.min) || new_range.include?(old_range.max)}
    if overlap_index.nil?
      new_ranges << old_range
    else
      new_range = new_ranges[overlap_index]
      lower = [old_range.min, new_range.min].min
      upper = [old_range.max, new_range.max].max
      new_ranges[overlap_index] = (lower..upper)
      merges = true
    end
  end

  ranges = new_ranges
end

puts ranges.map(&:size).inject(&:+)
