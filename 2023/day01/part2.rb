num_map = {'one' => '1', 'two' => '2', 'three' => '3', 'four' => '4', 'five' => '5', 'six' => '6', 'seven' => '7', 'eight' => '8', 'nine' => '9'}
rev_num_map = num_map.map{|k,v| [k.reverse, v]}.to_h

def find_number(calibration, number_map)
  number = calibration.match(Regexp.new("(\\d|#{number_map.keys.join('|')})"))[1]
  number.length > 1 ? number_map[number] : number
end

puts File.open('input.txt').each_line.map(&:chomp).inject(0) { |sum, calibration|
  sum + (find_number(calibration, num_map) + find_number(calibration.reverse, rev_num_map)).to_i
}
