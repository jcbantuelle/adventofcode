require 'pp'

a = 0
b = 0

loop do
  a = b | 65536
  b = 13284195

  loop do
    b = ((((a & 255) + b) & 16777215) * 65899) & 16777215
    break if 256 > a

    a /= 256
  end

  pp b
  exit
end
