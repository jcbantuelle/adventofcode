require 'pp'

code_length = 0
escaped_length = 0

File.foreach('input.txt') do |line|
  text = line.chomp
  code_length += text.length

  escaped_length += text.length + 2 + text.count('\\') + text.count('"')
end

pp escaped_length - code_length
