last_fourteen = []
File.open('input.txt').each_line.to_a.first.chomp.chars.each_with_index { |packet, i|
  last_fourteen.push(packet)
  last_fourteen.shift if last_fourteen.length > 14
  if last_fourteen.length == 14 && last_fourteen.uniq.length == 14
    puts i+1
    exit
  end
}
