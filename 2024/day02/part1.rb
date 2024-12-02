puts File.open('input.txt').select { |report|
  levels = report.chomp.split(' ').map(&:to_i)
  sorted = levels.sort
  (levels == sorted || levels.reverse == sorted) && levels.each_cons(2).all?{|a,b| a != b && (a-b).abs < 4}
}.length
