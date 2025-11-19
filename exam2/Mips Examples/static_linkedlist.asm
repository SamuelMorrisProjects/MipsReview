.text
.globl main
.ent main



main:
    la $s0, node1

    print_loop: 
        
        li $v0, 1 
        lw $a0, 0($s0)
        syscall
        lw   $t0, 4($s0)
        move $s0, $t0

        beqz $t0, end
        j print_loop
    
    end: 
        li $v0, 10 
        syscall

.end main

.data
# Linked list static version 
node1: .word 1  node2
node2: .word 2  node3
node3: .word 3  0 # Null ptr
