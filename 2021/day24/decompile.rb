monad = # 14 digit array

a = (((monad[0] + 3) * 26 + (monad[1] + 7)) * 26 + (monad[2] + 1))
b = a % 26 - 4

z = a / 26
z *= (b * 25 + 1) if b != monad[3]
z += ((monad[3] + 6) * b * 26 + monad[4] + 14) * 26 + monad[5] + 7

c = z % 26 - 4
z /= 26
z *= 26 if c != monad[6]

z += monad[6] + 9 * c

d = z % 26 - 12

z /= 26
z *= 25 * d + 1 if d != monad[7]
z += monad[7] + 9 * d
z *= 26 + monad[8] + 6

e = z % 26 - 11
if e != monad[9]
  z *= 25 * e + 1
  z += monad[9] + 4
end

w = monad[10]
z *= 26
z += monad[10]

w = monad[11]
mul x 0
add x z
mod x 26
div z 26
add x -1
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 7
mul y x
add z y

w = monad[12]
mul x 0
add x z
mod x 26
div z 26
add x 0
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 12
mul y x
add z y

w = monad[13]
mul x 0
add x z
mod x 26
div z 26
add x -11
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 1
mul y x
add z y
