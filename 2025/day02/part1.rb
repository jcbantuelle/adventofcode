def valid_id(id)
  if id.length % 2 != 0
    0
  else
    id.chars.each_slice(id.length/2).map(&:join).uniq.length == 1 ? id.to_i : 0
  end
end

puts File.open('test.txt').first.chomp.split(',').reduce(0) { |sum, id_range|
  first, second = id_range.split('-').map(&:to_i)
  sum + first.upto(second).reduce(0) { |invalid_ids, id|
    invalid_ids + valid_id(id.to_s)
  }
}
