puts File.open('input.txt').select { |full_report|
  levels = full_report.chomp.split(' ').map(&:to_i)
  (0..levels.length-1).map{ |i|
    levels.dup.tap{|l| l.delete_at(i)}
  }.any?{ |report|
    sorted = report.sort
    (report == sorted || report.reverse == sorted) && report.each_cons(2).all?{|a,b| a != b && (a-b).abs < 4}
  }
}.length
