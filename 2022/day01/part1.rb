puts File.open('input.txt').each_line.map(&:chomp).join(',').split(',,').map{ |elf|
  elf.split(',').map(&:to_i).inject(&:+)
}.max
