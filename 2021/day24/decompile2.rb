require 'pp'

def process(w, z, z_div, x_add, y_add)
  equals_w = (z % 26 + x_add) == w
  z /= z_div
  unless equals_w
    z *= 26
    z += w + y_add
  end
  z
end

operations = [
  [1, 11, 3],
  [1, 14, 7],
  [1, 13, 1],
  [26, -4, 6],
  [1, 11, 14],
  [1, 10, 7],
  [26, -4, 9],
  [26, -12, 9],
  [1, 10, 6],
  [26, -11, 4],
  [1, 12, 0],
  [26, -1, 7],
  [26, 0, 12],
  [26, -11, 1]
]

z > 312 && z < 546 && (z - 0) % 26 == w

z > 11 && z < 21 && (z - 11) % 26 == w

# 11111111111111.upto(99999999999999) do |i|
  i = 92967699949891
  monad = i.to_s.chars.map(&:to_i)
  # next if monad.include?(0)
  z = 0
  operations.each do |operation|
    pp z
    z = process(monad.shift, z, *operation)
    pp z
    pp ''
  end
# end
