            .data
arrayA:     .space 60
minus:      .float -1.0
one:        .float 1.0
msg:        .asciiz "The final value is: "
delimit:    .asciiz "\n"

            .text
            .globl main

main:       li $v0, 5                   # syscall 5 (read_int)
            syscall   
            addi $t0, $v0, 0            # Saving N in $t0
            xor $t1, $t1, $t1           # i = 0
            la $t2, arrayA              # load A[] address

initA:      li $v0, 6                   # syscall 6 (read_float)
            syscall 
            swc1 $f0, 0($t2)            # Storing element in A[i]
            addi $t2, $t2, 4            # move address to A[i+1]
            addi $t1, $t1, 1            # i = i + 1
            blt $t1, $t0, initA         # i < n then continue
            xor $t1, $t1, $t1           # i = 0

            la $t2, arrayA              # load A[] address to start computation
            lwc1 $f12, 0($t2)           # $f12 <-- (-1)^0*A[0]
            addi $t2, $t2, 4            # move address to A[1]
            addi $t1, $t1, 1            # i = i + 1
            bge $t1, $t0, out           # n = 1: exit
            l.s $f2, minus              # Load constant: $f2 <-- -1
            l.s $f4, one                # Initialize constant: $f4 <-- 1

comp:       lwc1 $f6, 0($t2)            # $f6 <-- A[i], starts at i = 1
            mul.s $f4, $f4, $f2         # $f4 <-- (-1)^(i-1)*(-1)
            mul.s $f6, $f6, $f4         # $f6 <-- (-1)^i*A[i]
            add.s $f12, $f12, $f6       # $f12 = $f12 + (-1)^i*A[i]
            addi $t2, $t2, 4            # move address to A[i+1]
            addi $t1, $t1, 1            # i = i + 1
            blt $t1, $t0, comp          # i < n then continue

out:        la $a0, msg                 # Load message for printing
            li $v0, 4                   # syscall 4 (print_string)
            syscall
            li $v0, 2                   # syscall 2 (print_float) - result already stored in f12
            syscall
            li $v0, 4                   # syscall 4 (print_string)
            la $a0, delimit             # print \n for delimiting
            syscall
            jr $ra                      # return to caller
