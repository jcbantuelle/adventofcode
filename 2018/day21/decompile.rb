start_value = 0
registers = [start_value,0,0,0,0,0]
instruction_count = 0

# Instruction 0
# seti 123 _ 5 # 0
registers[5] = 123
instruction_count += 1

# Instruction 1
# bani 5 456 5
registers[5] = registers[5] & 456
instruction_count += 1

# Instruction 2
# eqri 5 72 5
registers[5] = registers[5] == 72 ? 1 : 0
instruction_count += 1

# Instruction 3
# addr 5 1 1
registers[1] = 3 + registers[5]
instruction_count += 1
goto 5 if registers[5] == 1

# Instruction 4
# seti 0 _ 1
registers[1] = 0
instruction_count += 1
goto 1

# Instruction 5
# seti 0 _ 5
registers[5] = 0
instruction_count += 1

# Instruction 6
# bori 5 65536 4
registers[4] = registers[5] | 65536
instruction_count += 1

# Instruction 7
# seti 13284195 _ 5
registers[5] = 13284195
instruction_count += 1

# Instruction 8
# bani 4 255 3
registers[3] = registers[4] & 255
instruction_count += 1

# Instruction 9
# addr 5 3 5
registers[5] += registers[3]
instruction_count += 1

# Instruction 10
# bani 5 16777215 5
registers[5] &= 16777215
instruction_count += 1

# Instruction 11
# muli 5 65899 5
registers[5] *= 65899
instruction_count += 1

# Instruction 12
# bani 5 16777215 5
registers[5] &= 16777215
instruction_count += 1

# Instruction 13
# gtir 256 4 3
registers[3] = 256 > registers[4] ? 1 : 0
instruction_count += 1

# Instruction 14
# addi 3 14 1
registers[1] = registers[3] + 14
instruction_count += 1
goto 16 if 256 > registers[4]

# Instruction 15
# addi 1 _ 1
registers[1] = 16
instruction_count += 1
goto 17

# Instruction 16
# seti 27 _ 1
registers[1] = 27
instruction_count += 1
goto 28

# Instruction 17
# seti 0 _ 3
registers[3] = 0
instruction_count += 1

# Instruction 18
# addi 3 1 2
registers[2] = registers[3] + 1
instruction_count += 1

# Instruction 19
# muli 2 256 2
registers[2] *= 256
instruction_count += 1

# Instruction 20
# gtrr 2 4 2
registers[2] = registers[2] > registers[4] ? 1 : 0
instruction_count += 1

# Instruction 21
# addi 2 21 1
registers[1] = registers[2] + 21
instruction_count += 1
goto 23 if registers[2] > registers[4]

# Instruction 22
# addi 1 1 1
registers[1] = 23
instruction_count += 1
goto 24

# Instruction 23
# seti 25 _ 1
registers[1] = 25
instruction_count += 1
goto 26

# Instruction 24
# addi 3 1 3
registers[3] += 1
instruction_count += 1

# Instruction 25
# seti 17 _ 1
registers[1] = 17
instruction_count += 1
goto 18

# Instruction 26
# setr 3 _ 4
registers[4] = registers[3]
instruction_count += 1

# Instruction 27
# seti 7 _ 1
registers[1] = 7
instruction_count += 1
goto 8

# Instruction 28
# eqrr 5 0 3
registers[3] = registers[5] == registers[0] ? 1 : 0
instruction_count += 1

# Instruction 29
# addi 3 29 1
registers[1] = registers[3] + 29
instruction_count += 1
exit if registers[5] == registers[0]

# Instruction 30
# seti 5 _ 1
registers[1] = 5
instruction_count += 1
goto 6
