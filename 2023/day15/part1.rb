require 'pp'

File.open('test.txt').each_line{ |line|
  pp line.chomp.split(',').inject(0) {|total, str|
    total + str.each_char.inject(0){|current, chr| ((current + chr.ord) * 17) % 256}
  }
}
