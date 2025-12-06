def valid_id(id)
  1.upto(id.length / 2) do |slice_length|
    if id.length % slice_length == 0
      slices = id.chars.each_slice(slice_length).map(&:join)
      return id.to_i if slices.uniq.length == 1
    end
  end
  0
end

puts File.open('input.txt').first.chomp.split(',').reduce(0) { |sum, id_range|
  first, second = id_range.split('-').map(&:to_i)
  sum + first.upto(second).reduce(0) { |invalid_ids, id|
    invalid_ids + valid_id(id.to_s)
  }
}
