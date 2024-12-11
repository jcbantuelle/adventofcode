stones = File.open('input.txt').first.chomp.split(' ')
25.times { |i|
  stones.map!{|stone|
    if stone == "0"
      "1"
    elsif stone.length % 2 == 0
      stone.chars.each_slice(stone.length / 2).map{|new_stone| new_stone.join.to_i.to_s}
    else
      (stone.to_i * 2024).to_s
    end
  }.flatten!
}
puts stones.length
