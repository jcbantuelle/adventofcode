$ip = 0
$registers = [0,0,0,0,0,0]

def register_update(register, value)
  $registers[register] = value
  if register == 4
    $ip = value + 1
  else
    $ip += 1
  end
end

# Instruction 0
# addi 4 16 4
# reg[4] += 16
update_register(4, 16)
goto $ip # Instruction 17

# Instruction 1
# seti 1 _ 1
# reg[1] = 1
update_register(1, 1)

# Instruction 2
# seti 1 _ 3
# reg[3] = 1
update_register(3, 1)

# Instruction 3
# mulr 1 3 2
# reg[2] = reg[1] * reg[3]
update_register(2, $registers[1] * $registers[3])

# Instruction 4
# eqrr 2 5 2
# reg[2] = reg[2] == reg[5] ? 1 : 0
update_register(2, $registers[2] == $registers[5] ? 1 : 0)

# Instruction 5
# addr 2 4 4
# reg[4] += reg[2]
update_register(4, $registers[2] + 5)
goto $ip

# Instruction 6
# addi 4 1 4
# reg[4] += 1
update_register(4, 7)
goto $ip # Instruction 8

# Instruction 7
# addr 0 1 0
# reg[0] += reg[1]
update_register(0, $registers[0] + $registers[1])

# Instruction 8
# addi 3 1 3
# reg[3] += 1
update_register(3, $registers[3] + 1)

# Instruction 9
# gtrr 3 5 2
# reg[2] = reg[3] > reg[5] ? 1 : 0
update_register(2, $registers[3] > $registers[5] ? 1 : 0)

# Instruction 10
# addr 4 2 4
# reg[4] += reg[2]
update_register(4, $registers[2] + 10)
goto $ip

# Instruction 11
# seti 2 _ 4
# reg[4] = 2
update_register(4, 2)
goto $ip # Instruction 3

# Instruction 12
# addi 1 1 1
# reg[1] += 1
update_register(1, $registers[1] + 1)

# Instruction 13
# gtrr 1 5 2
# reg[2] = reg[1] > reg[5] ? 1 : 0
update_register(2, $registers[1] > $registers[5] ? 1 : 0)

# Instruction 14
# addr 2 4 4
# reg[4] += reg[2]
update_register(4, $registers[2] + 14)
goto $ip

# Instruction 15
# seti 1 _ 4
# reg[4] = 1
update_register(4, 1)
goto $ip # Instruction 2

# Instruction 16
# mulr 4 4 4
# reg[4] = 256
update_register(4, 256)
exit

# Instruction 17
# addi 5 2 5
# reg[5] += 2
update_register(5, $registers[5] + 2)

# Instruction 18
# mulr 5 5 5
# reg[5] *= reg[5]
update_register(5, $registers[5] * $registers[5])

# Instruction 19
# mulr 4 5 5
# reg[5] *= reg[4]
update_register(5, $registers[5] * 19)

# Instruction 20
# muli 5 11 5
# reg[5] *= 11
update_register(5, $registers[5] * 11)

# Instruction 21
# addi 2 1 2
# reg[2] += 1
update_register(2, $registers[2] + 1)

# Instruction 22
# mulr 2 4 2
# reg[2] *= reg[4]
update_register(2, $registers[2] * 22)

# Instruction 23
# addi 2 6 2
# reg[2] += 6
update_register(2, $registers[2] + 6)

# Instruction 24
# addr 5 2 5
# reg[5] += reg[2]
update_register(5, $registers[5] + $registers[2])

# Instruction 25
# addr 4 0 4
# reg[4] += reg[0]
update_register(4, $registers[0] + 25)
goto $ip

# Instruction 26
# seti 0 _ 4
# reg[4] = 0
update_register(4, 0)
goto $ip # Instruction 1

# Instruction 27
# setr 4 _ 2
# reg[2] = 27
update_register(2, 27)

# Instruction 28
# mulr 2 4 2
# reg[2] *= 28
update_register(2, $registers[2] * 28)

# Instruction 29
# addr 4 2 2
# reg[2] += 29
update_register(2, $registers[2] + 29)

# Instruction 30
# mulr 4 2 2
# reg[2] *= 30
update_register(2, $registers[2] * 30)

# Instruction 31
# muli 2 14 2
# reg[2] *= 14
update_register(2, $registers[2] * 14)

# Instruction 32
# mulr 2 4 2
# reg[2] *= 32
update_register(2, $registers[2] * 32)

# Instruction 33
# addr 5 2 5
# reg[5] += reg[2]
update_register(5, $registers[5] + $registers[2])

# Instruction 34
# seti 0 _ 0
# reg[0] = 0
update_register(0, 0)

# Instruction 35
# seti 0 _ 4
# reg[4] = 0
update_register(4, 0)
goto $ip # Instruction 1
