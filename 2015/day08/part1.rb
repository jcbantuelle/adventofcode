require 'pp'

code_length = 0
escaped_length = 0

File.foreach('input.txt') do |line|
  text = line.chomp
  code_length += text.length

  text = text[1..text.length-2]

  text.gsub!(/\\\\/,"z")
  text.gsub!(/\\\"/,"z")
  text.gsub!(/\\x[0-9a-f]{2}/,"z")

  escaped_length += text.length
end

pp code_length - escaped_length
