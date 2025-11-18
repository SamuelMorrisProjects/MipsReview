.globl main
.ent main

.text
main:
    la $a0, filepath
    li $a1, 0                   # Flags
    li $a2, 0
    li $v0, 13
    syscall 
    move $s0, $v0

    loop_: 
        move $a0, $s0
        la $a1, buffer
        li $a2, 1024
        li $v0, 14
        syscall 

        beqz $v0, exit_loop
        move $s1, $v0
        li $t0, 0 
        inner_loop: 
            beq $t0, $s1, exit_il
            la $t3, buffer
            add $t2, $t0, $t3

            lb $a0, 0($t2) 
            li $v0, 11
            syscall
            addi $t0, $t0, 1
            j inner_loop
        exit_il:
        j loop_

    exit_loop: 
    move $a0, $s0
    li $v0, 16
    syscall

    li $v0, 10 
    syscall
.end main



.data
buffer: .space 1024
# Change this depending on the OS
filepath: .asciiz "/home/samuel/313files/silly.txt"