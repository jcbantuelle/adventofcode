require 'pp'

seen = {}
a = 0
b = 0

loop do
  old_b = b
  a = b | 65536
  b = 13284195
  key = "#{a},#{b}"
  if seen[key]
    pp old_b
    exit
  end
  seen[key] = true

  loop do
    b = ((((a & 255) + b) & 16777215) * 65899) & 16777215
    break if 256 > a

    a /= 256
  end

end
