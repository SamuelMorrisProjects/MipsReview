# You can attach methods to objects in mips via dynamic dispatch
# this can be done statically or dyncamically
# For instance 
.globl main
.ent main

# a0 - instance of person class
# a1 - address to the greeting 
greet_person:
	addiu $sp, $sp -8
	sw $v0, 0($sp)
	sw $a0, 4($sp)

	move $a0,$a1
	li $v0, 4 
	syscall

	li $a0, ' '
	li $v0, 11
	syscall 

	lw $a0, 4($sp)
    lw $a0, 0($a0)         
	li $v0, 4
	syscall

	li $a0, ' '
	li $v0, 11
	syscall 

	lw $a0, 4($sp)
	lw $a0, 4($a0)
	li $v0, 4 
	syscall

	lw $a0, 4($sp)
	lw $v0, 0($sp)
	addiu $sp, $sp, 8
	jr $ra

main:
	la $a1, greeting
	la $t0, person1
	lw $t0, 8($t0)
	la $a0, person1
	jalr $t0
	li $v0, 10 
	syscall


.end main

.data 
fname: .asciiz "Sam"
lname: .asciiz "coolpants"
greeting: .asciiz "Yo wassup"

person1: .word fname
		 .word lname
		 .word greet_person

