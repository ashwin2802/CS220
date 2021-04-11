            .data
arrayA:     .space 60
arrayB:     .space 60
msg:        .asciiz "The final value is: "
endmsg:     .asciiz "\n"

            .text
            .globl main

main:       li $v0, 5                   # syscall 5 (read_int)
            syscall   
            addi $t0, $v0, 0            # Saving N in $t0
            xor $t1, $t1, $t1           # Initializing i = 0 in $t1
            la $t2, arrayA              # load A[] address
            la $t3, arrayB              # load B[] address

initA:      li $v0, 6                   # syscall 6 (read_float)
            syscall 
            swc1 $f0, 0($t2)            # Storing element in A[i]
            addi $t2, $t2, 4
            addi $t1, $t1, 1            # i = i + 1
            blt $t1, $t0, initA         # i < n then continue
            xor $t1, $t1, $t1           # resetting i = 0

initB:      li $v0, 6                   # syscall 6 (read_float)
            syscall 
            swc1 $f0, 0($t3)            # Storing elements in B[i]
            addi $t3, $t3, 4
            addi $t1, $t1, 1            # i = i + 1
            blt $t1, $t0, initB         # i < n then continue
            xor $t1, $t1, $t1           # resetting i = 0

initComp:   lwc1 $f1, -4($t2)           # load A[n-1]
            lwc1 $f2, -4($t3)           # load B[n-1]
            mul.s $f12, $f1, $f12       # store A[n-1]*B[n-1]
            addi $t2, $t2, -8           # set to A[n-2] address
            addi $t3, $t3, -8           # set to B[n-2] address
            addi $t1, $t1, 1            # 1 element processed, i = i +
            bge $t1, $t0, out           # Handles N = 1 case: direct output

comp:       lwc1 $f1, 0($t2)            # Fetch A[x]
            lwc1 $f2, 0($t3)            # Fetch B[x]
            mul.s $f2, $f1, $f12        # A[x]*B[x]
            add.s $f12, $f12, $f2       # Add to sum in f12
            addi $t2, $t2, -4           # move to next element in A
            addi $t3, $t3, -4           # move to next element in B
            addi $t1, $t1, 1            # 1 more element processed, i = i + 1
            blt $t1, $t0, comp          # continue if i < n

out:        la $a0, msg                 # Load message for printing
            li $v0, 4                   # syscall 4 (print_string)
            syscall
            li $v0, 2                   # syscall 2 (print_float) - result already stored in f12
            syscall
            li $v0, 4                   # syscall 4 (print_string)
            la $a0, endmsg              # print \n for delimiting
            syscall
            jr $ra





