.data
arrayA : .space 60
arrayB : .space 60
invalid : .asciiz "No values entered\n"
msg : .asciiz "The final value is : "
endmsg : .asciiz "\n"

.text
.globl main

main : 
    li $v0,5
    syscall   
    addi $t0,$v0,0          # Saving N in $t0
    xor $t1,$t1,$t1         # Initializing i = 0 in $t1
    la $t2,arrayA         
    la $t3,arrayB
    slt $t4,$t1,$t0
    beq $t4,$0 end1

initializing_A :            # Insert entire vector A
    li $v0,6
    syscall 
    swc1 $f0,0($t2)         # Storing element in A[i]
    addi $t2,$t2,4
    addi $t1,$t1,1          # i = i+1
    blt $t1,$t0,initializing_A
    xor $t1,$t1,$t1         # resetting i=0

initializing_B :            # Insert entire vector B
    li $v0,6
    syscall 
    swc1 $f0,0($t3)         # Storing elements in B[i]
    addi $t3,$t3,4
    addi $t1,$t1,1          # i = i+1
    blt $t1,$t0,initializing_B    
    xor $t1,$t1,$t1         # resetting i=0

computation_initialization :
    lwc1 $f1,-4($t2)
    lwc1 $f2,-4($t3)
    mul.s $f12,$f1,$f2
    addi $t2,$t2,-8
    addi $t3,$t3,-8
    addi $t1,$t1,1          # i = i+1   
    bge $t1,$t0,output      # Handles N=1 case

computation :
    lwc1 $f1,0($t2)
    lwc1 $f2,0($t3)
    mul.s $f2,$f1,$f2
    add.s $f12,$f12,$f2
    addi $t2,$t2,-4
    addi $t3,$t3,-4
    addi $t1,$t1,1          #i = i+1
    blt $t1,$t0,computation

output :                    # To handle cases where N >0
    li $v0,4
    syscall
    li $v0,2
    syscall
    li $v0,4
    la $a0,endmsg
    syscall
    li $v0,10
    syscall

    
end1 :                       # To handle the case where N=0
    la $a0,invalid
    li $v0,4
    syscall
    li $v0,10
    syscall





