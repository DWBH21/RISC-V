# .section 

# .data 
# .dword 4, 12, 3, 125, 50, 32, 16, 4, 0

.text
    # The following line initializes register x3 with 0x10000000 
    # so that you can use x3 for referencing various memory locations. 
    lui x3, 0x10000
    #your code starts here       
    
    # load the count in x5
    ld x5, 0(x3) 
    
    # increment x3 to get operands
    addi x3, x3, 8
    
    # using x11 as memory location for result
    lui x11, 0x10000
    addi x11, x11, 0x200
    
    # initialize loop counter
    addi x6, x0, 1
    
LOOP:
    blt x5, x6, EXIT

    # load operands in x8 and x9
    ld x8, 0(x3)
    ld x9, 8(x3) 
    
    # calculating gcd, result will be stored in x10
GCD:
    bne x8, x0, NEXT1            
    add x10, x0, x0            # executed if x8 == 0
    beq x0, x0, DONE
    
NEXT1:
    bne x9, x0, NEXT2
    add x10, x0, x0            # executed if x9 == 0
    beq x0, x0, DONE
    
NEXT2: 
    bne x8, x9, NEXT3
    add x10, x8, x0          # executed if x8 == x9
    beq x0, x0, DONE   
     
NEXT3:    
    bltu x8, x9, NEXT4
    sub x8, x8, x9             # executed if x8 >= x9 (unsigned)
    beq x0, x0, GCD
    
NEXT4:
    sub x9, x9, x8            # executed if x8 < x9 (unsigned) 
    beq x0, x0, GCD
    
DONE:        
    # storing result in memory location 
    sd x10, 0(x11)
    
    # increment counters and offsets
    addi x6, x6, 1
    addi x3, x3, 16
    addi x11, x11, 8
    beq x0, x0, LOOP
    
EXIT:
    beq x0, x0, EXIT