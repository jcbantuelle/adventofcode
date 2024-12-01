last_four = []
File.open('input.txt').each_line.to_a.first.chomp.chars.each_with_index { |packet, i|
  last_four.push(packet)
  last_four.shift if last_four.length > 4
  if last_four.length == 4 && last_four.uniq.length == 4
    puts i+1
    exit
  end
}
