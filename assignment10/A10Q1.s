            .text
            .globl find
            .globl main

find:       

main:       li $v0, 5               # syscall 5 (read_int)
            syscall                 
            add $t0, $0, $v0        # store n
            xor $t1, $t1, $t1       # i = 0
            la $t2, array           # $t2 <-- *array

initA:      li $v0, 5               # syscall 5 (read_int)
            syscall
            sw $v0, 0($t2)          # store A[i]
            addi $t2, $t2, 4        # move to A[i+1] address
            addi $t1, $t1, 1        # i = i + 1
            blt $t1, $t0, initA     # i < n then continue

            li $v0, 5               # syscall 5 (read_int)
            syscall
            add $t1, $0, $v0        # store k

            la $a0, arrayA          # first argument: *arrayA
            xor $a1, $a1, $a1       # second argument: start = 0
            addi $a2, $t0, -1       # third argument: end = n-1
            add $a3, $t1, $0        # fourth argument: key = k
            addi $sp, $sp, -4
            sw $ra, 0($sp)          # store return address
            jal find                # call binary search

            bltz $v0, $0, absent    # function returned -1: no match found
            add $a1, $v0, $0        # store result in $a1
            li $v0, 4               # syscall 4 (print_string)
            la $a0, pass            # Print pass message
            syscall
            li $v0, 1               # syscall 1 (print_int)
            add $a0, $0, $a1        # Print index from $a1
            syscall
            j exit                  # skip to termination

absent:     li $v0, 4               # syscall 4 (print_string)
            la $a0, fail            # Print fail message
            syscall

exit:       lw $ra, 0($sp)
            addi $sp, $sp, 4        # terminate program
            li $v0, 4               # syscall 4 (print_string)
            la $a0, delimit         # add a \n at the end
            syscall
            jr $ra                  # return

            .data
pass:       .asciiz "Found element at index "
fail:       .asciiz "Element was not found"
delimit:    .asciiz "\n"
arrayA:     .space 48