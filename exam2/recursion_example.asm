.globl main
.ent main
.text
newline_out:
    addiu $sp, $sp, -8
    sw $a0, 0($sp)
    sw $v0, 4($sp)
    la $a0, newline
    li $v0, 4
    syscall
    lw $a0, 0($sp)
    lw $v0, 4($sp)
    addi $sp, $sp, 8
    jr $ra 
.end newline_out






#a0 - the number
count_down:
	addiu $sp, $sp, -8

	sw $ra, 0($sp)
	sw $a0, 4($sp)
	li $v0, 1 
	syscall
	jal newline_out

	beqz $a0, exit_count_down
	addi $a0, $a0, -1
	jal count_down
	exit_count_down:
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		addiu $sp, $sp, 8
		jr $ra
.end count_down

fibonnaci_basecase0:
	li $v0, 0
	jr $ra              # FIXED: jr not j
	
fibonnaci_basecase1:
	li $v0, 1 
	jr $ra 

fibonnaci:
	li $t1, 1 
	beqz $a0,     fibonnaci_basecase0
	beq $t1, $a0, fibonnaci_basecase1
	
    addiu $sp, $sp, -12      # Allocate 12 bytes
    sw $ra, 0($sp)
	sw $a0, 4($sp)
	
    addiu $a0, $a0, -1
    jal fibonnaci
    sw $v0, 8($sp)           # Save result on STACK not in $t0!
    
    lw $a0, 4($sp)
    addiu $a0, $a0, -2
    jal fibonnaci
    
    lw $t0, 8($sp)           # Load first result from stack
    add $v0, $v0, $t0
    
    lw $ra, 0($sp)
    addiu $sp, $sp, 12
    jr $ra


main:
#	li $a0, 10
#	jal count_down 

#	li $a0, 6
#	jal fibonnaci

	move $a0, $v0
	li $v0, 1
	syscall

	li $v0, 10 
	syscall
.end main



.data
newline: .asciiz "\n"
