puts File.open('input.txt').each_line
  .select{|line|
    pair = line.chomp.split(',').map{|assignment|
      range = assignment.split('-').map(&:to_i)
      (range[0]..range[1])
    }
    (pair[0].cover?(pair[1].begin) && pair[0].cover?(pair[1].end)) ||
    (pair[1].cover?(pair[0].begin) && pair[1].cover?(pair[0].end))
  }.count
