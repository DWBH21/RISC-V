# loading first operand from 0x10000000 in x7
addi x20, x0, 1
slli x20, x20, 28
ld x7, 0(x20)

#loading second operand from 0x10000008 in x8
ld x8, 8(x20)

# Copy first operator to x5 and second operand to x6
addi x5, x7, 0
addi x6, x8, 0

# extract the signs of the two operands and take their modulus
# final sign of product will be stored in x10, 1 if negative and 0 if positive
sub x10, x10, x10 

bge x7, x0, POS1
sub x5, x0, x7
addi x10, x0, 1

POS1:
bge x8, x0, POS2
sub x6, x0, x8
xori x10, x10, 1

POS2:

# initialize sum to 0, to be stored in register x9
sub x9, x9, x9

# mask (x12 = 1) 
addi x12, x0, 1

LOOP:
    
# loop condition (while mask > 0)
blt x12, x0, DONE

# x14 = (first_operand) AND mask
and x14, x5, x12

# to check condition: if x14 > 0 
bge x0, x14, BITNOTSET

# update the sum 
add x9, x9, x6

BITNOTSET: 

# left shift mask and second operand 
slli x12, x12, 1
slli x6, x6, 1

bge x0, x0, LOOP

DONE:
# check if result is negative
beq x10, x0, END

# make result negative 
sub x9, x0, x9

END:

# storing final value in memory location 0x10000050
sd x9, 80(x20)
