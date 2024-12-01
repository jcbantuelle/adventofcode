require 'pp'

directions = nil

File.foreach('input.txt') do |line|
  directions = line.chomp
  break
end

floor = 0
directions.each_char{ |char|
  floor += char == '(' ? 1 : -1
}

pp floor
