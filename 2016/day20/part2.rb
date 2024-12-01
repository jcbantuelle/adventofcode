require 'pp'

ranges = []

File.foreach('input.txt') do |line|
  ranges.push(line.chomp.split('-').map(&:to_i))
end

merged = true
while merged
  merged = false
  new_ranges = ranges.map(&:dup)
  ranges.each_with_index do |r1, i|
    ranges.each_with_index do |r2, j|
      next if i == j
      if (r2[0]..r2[1]).include?(r1[0])
        merged_range = [r2[0], [r1[1],r2[1]].max]
        merged = true
        deletions = [i,j].sort
        new_ranges.delete_at(deletions[0])
        new_ranges.delete_at(deletions[1]-1)
        new_ranges.push(merged_range)
        break
      elsif (r2[0]..r2[1]).include?(r1[1])
        merged_range = [[r1[0],r2[0]].min, r2[1]]
        merged = true
        deletions = [i,j].sort
        new_ranges.delete_at(deletions[0])
        new_ranges.delete_at(deletions[1]-1)
        new_ranges.push(merged_range)
        break
      end
    end
    break if merged
  end
  ranges = new_ranges
end

max = 4294967296
ranges.each do |range|
  max -= (range[1]-range[0]+1)
end
pp max
