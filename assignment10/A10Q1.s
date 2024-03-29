            .text
            .globl find
            .globl main

            # Assuming inputs are given in ascending order

find:       beq $a1, $a2, base        # Checking if (start==end) the base case
            addi $sp, $sp, -4
            sw $ra, 0($sp)           # Storing $ra on the stack
            add $t0, $a1, $a2
            srl $t0, $t0, 1           # Computing mid = (start+end)/2 
            sll $t1, $t0, 2
            add $t2, $a0, $t1         # Computing A[mid]
            lw $t2, 0($t2)
            blt $t2, $a3, case1       # Case A[mid] < k
            beq $t2, $a3, case2       # Case A[mid] = k
            addi $a2, $t0, -1         # Setting end = mid-1
            jal find                  # Case A[mid] < k
            lw $ra, 0($sp)
            addi $sp, $sp, 4
            jr $ra

case1:      addi $a1, $t0, 1          # Setting start = mid +1
            jal find
            lw $ra, 0($sp)
            addi $sp, $sp, 4
            jr $ra    

case2:      add $v0, $0, $t0          # Returing mid
            addi $sp, $sp, 4
            jr $ra

base:       sll $t1, $a1, 2          # Computing 4*start
            add $t2, $a0, $t1
            lw $t3, 0($t2)           # Computing A[start]
            beq $t3, $a3, hit
            addi $v0, $0, -1         # Key not found and returning -1
            jr $ra

hit:        add $v0, $0, $a1          # returning start
            jr $ra

main:       li $v0, 5               # syscall 5 (read_int)
            syscall                 
            add $t0, $0, $v0        # store n
            xor $t1, $t1, $t1       # i = 0
            la $t2, arrayA           # $t2 <-- *array

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

            bltz $v0, absent        # function returned -1: no match found
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