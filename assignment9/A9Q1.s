            .text
            .globl fib
            .globl main

fib:        slti $t0, $a0, 3        # base case: n = 1, 2 < 3
            beq $t0, $0, basent     # jump to base case
            addi $v0, $0, 1         # base fib(1)=fib(2)=1
            jr $ra                  # return

basent:     addi $sp, $sp, -8       # reserve stack space
            sw $ra, 4($sp)          # store return address
            sw $a0, 0($sp)          # store caller saved a0 = n
            addi $a0, $a0, -1       # prepare for n-1 call
            jal fib                 # call fib(n-1)
            lw $a0, 0($sp)          # fetch n
            sw $v0, 0($sp)          # store fib(n-1)
            addi $a0, $a0, -2       # prepare for n-2 call
            jal fib                 # call fib(n-2)
            lw $t1, 0($sp)
            add $v0, $t1, $v0       # compute fib(n-1) + fib(n-2)
            lw $ra, 4($sp)          # fetch return address
            addi $sp, $sp, 8        # update stack pointer
            jr $ra                  # return   

main:       li $v0, 5               # syscall 5 (read_int)
            syscall                 
            add $t2, $0, $v0        # store n
            addi $sp, $sp, -4
            sw $ra, 0($sp)          # store return address
            addi $t3, $0, 1         # store x = 1

iterate:    add $a0, $0, $t3        # load x for function
            jal fib
            addi $t3, $t3, 1        # x = x + 1
            add $a0, $0, $v0        # prepare to return fib(x) 
            li $v0, 1               # print fib(x)
            syscall
            sle $t4, $t3, $t2       # check x + 1 <= n
            beq $t4, $0, exit       # exit loop if false
            li $v0, 4   
            la $a0, sep             # print separator
            syscall
            j iterate               # continue

exit:       lw $ra, 0($sp)
            addi $sp, $sp, 4        # terminate program
            li $v0, 4               # syscall 4 (print_string)
            la $a0, delimit         # add a \n at the end
            syscall
            jr $ra                  # return

            .data
sep:        .asciiz ", "
delimit:    .asciiz "\n"