require 'pp'

directions = nil

File.foreach('input.txt') do |line|
  directions = line.chomp
  break
end

floor = 0
directions.each_char.to_a.each_with_index{ |char, index|
  floor += char == '(' ? 1 : -1
  if floor == -1
    pp index+1
    break
  end
}
