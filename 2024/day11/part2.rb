stones = File.open('input.txt').first.chomp.split(' ').map{|stone| [stone,1]}.to_h

75.times {
  new_stones = {}
  stones.each{|stone, count|
    if stone == "0"
      new_stones["1"] ||= 0
      new_stones["1"] += count
    elsif stone.length % 2 == 0
      l,r = stone.chars.each_slice(stone.length / 2).map{|new_stone| new_stone.join.to_i.to_s}
      new_stones[l] ||= 0
      new_stones[l] += count
      new_stones[r] ||= 0
      new_stones[r] += count
    else
      mult = (stone.to_i * 2024).to_s
      new_stones[mult] ||= 0
      new_stones[mult] += count
    end
  }
  stones = new_stones
}
puts stones.values.inject(&:+)
