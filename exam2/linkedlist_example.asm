#       Pratice for exam 2
#       Simple linked list impl

.text
.globl main
.ent main
alloc:
    li $v0, 9
    syscall
    jr $ra

# memcpy(dest, src, num_bytes)
# a0 = destination
# a1 = source  
# a2 = number of bytes to copy
memcpy:
	addiu $sp, $sp, -12 # saving a1 and a0 on the stack may not be right
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
    beqz $a2, memcpy_done
    memcpy_loop:
        lb $t0, 0($a1)      # Load byte from source
        sb $t0, 0($a0)      # Store byte to dest
        addiu $a0, $a0, 1   # Increment dest
        addiu $a1, $a1, 1   # Increment source
        addiu $a2, $a2, -1  # Decrement count
        bnez $a2, memcpy_loop
    memcpy_done:
    	lw $a0, 0($sp)
		lw $a1, 4($sp)
		lw $a2, 8($sp)
		addiu $sp, $sp, 12
        jr $ra
.end memcpy

#  NODE LAYOUT
# [data...| NODE*]


#Args: a0, size of the data block
#Ret: v0, the memory of the node
init_empty_node:
	addiu $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    addiu $a0, $a0, 4
    jal alloc
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    addiu $sp, $sp, 8
    jr $ra
.end init_empty_node

#Args:
#a0 - Pointer to the memory you want in the node. (Pass by value)
#a1 - The size of the actual memory
#Ret:
# v0 - the memory of the node
init_node:
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)

	move $a0, $a1
	jal init_empty_node
	lw   $a1, 4($sp) #src <-mem_ptr
	move $a0, $v0    #dest <-data_mem of node
	lw   $a2, 8($sp) #size <-size_of data
	jal memcpy

	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	addiu $sp, $sp, 16
	jr $ra 
.end init_node

#Args:
#a0 - pointer to the node
#a1 - the size of the data in the node
#Ret: 
#v0 - next node pointer
next_node: addu $v0, $a0, $a1
		   jr $ra
.end next_node


#  LINKED LIST LAYOUT (offset)(datatype)
# (0)[word LENGTH]    (4)[word (DATA/MEM SIZE)] 
# (8)[Node* head ptr] (12)[Node* tail_ptr]


# Args: a0 size of mem inside each node
# Ret:  v0 linked list mem-
init_llist:
    addiu $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    li $a0, 16
    jal alloc
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    sw $a0, 4($v0)

    move $t0, $zero
    sw   $t0, 0($v0)

    addiu $sp, $sp, 8
    jr $ra
.end init_ll_list

# Args: 
# a0 - The linked list itself 
# a1 - pointer to data you want to append
append_llist:
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $v0, 4($sp)
	sw $a0, 8($sp)
	sw $a1, 12($sp)

	lw $t0, 0($a0)

    beqz $t0, apll_empty_case # len(list)==0
    j apll_else_case
    apll_empty_case:
    	move $a0,   $a1
    	lw $t0,   8($sp)
    	lw $a1,   4($t0)
    	jal init_node
    	lw $a0,  8($sp)

		sw $v0,  8($a0)
		sw $v0, 12($a0)
		j ret_ll_list
    apll_else_case:
    	move $a0,   $a1
    	lw $t0,   8($sp)
    	lw $a1,   4($t0)
    	jal init_node
    	lw $a0,  8($sp)
    	lw $t0,  12($a0)
    	lw $t1,  4($a0)
    	addu $t0, $t0, $t1
    	sw $v0, 0($t0)
    	sw $v0, 12($a0)
    	


       
    ret_ll_list:
    	lw $a0, 8($sp)
    	lw $t0, 0($a0)
        addiu $t0, $t0, 1
        sw $t0, 0($a0)

		lw $ra, 0($sp)
		lw $v0, 4($sp)
		
		lw $a1, 12($sp)
		addiu $sp, $sp, 16
        jr $ra
.end append_llist


main:
    addiu $sp, $sp, -4
    sw $ra, 0($sp)
    
    # Initialize linked list with node data size of 4 bytes (1 word)
    li $a0, 4
    jal init_llist
    move $s0, $v0           # Save list pointer in $s0
    
    # Test 1: Append first value (42)
    la $t0, test_val1
    move $a0, $s0
    move $a1, $t0
    jal append_llist
    
    # Test 2: Append second value (99)
    la $t0, test_val2
    move $a0, $s0
    move $a1, $t0
    jal append_llist
    
    # Test 3: Append third value (17)
    la $t0, test_val3
    move $a0, $s0
    move $a1, $t0
    jal append_llist
    
    # Print list length
    li $v0, 1
    lw $a0, 0($s0)
    syscall
    
    # Print newline
    li $a0, 10
    li $v0, 11
    syscall
    
    # Traverse and print list contents
    lw $s1, 8($s0)          # Get head pointer
    lw $s2, 0($s0)          # Get length
    lw $s3, 4($s0)          # Get data size
    
print_loop:
    beqz $s2, done_printing
    
    # Print the value at current node
    lw $a0, 0($s1)
    li $v0, 1
    syscall
    
    # Print space
    li $a0, 32
    li $v0, 11
    syscall
    
    # Get next node pointer
    move $a0, $s1
    move $a1, $s3
    jal next_node
    lw $s1, 0($v0)          # Load next node pointer
    
    addiu $s2, $s2, -1
    j print_loop
    
done_printing:
    # Print final newline
    li $a0, 10
    li $v0, 11
    syscall
    
    lw $ra, 0($sp)
    addiu $sp, $sp, 4
    li $v0, 10
    syscall

.data
test_val1: .word 42
test_val2: .word 99
test_val3: .word 17

