.globl main
.ent main
.text
# a0 - the address of the string you want to print
print_str:
    addiu $sp, $sp, -4
    sw $v0, 0($sp)
    li $v0, 4
    syscall
    lw $v0, 0($sp)
    addiu $sp, $sp, 4
    jr $ra
.end print_str

main:

    la $a0, prompt
    jal print_str

    li $v0, 5
    syscall

    addiu $v0, $v0, -1

    sll $t0, $v0, 2
    la $t1, jump_table_print_day
    add $t0, $t0, $t1
    lw $t0, 0($t0)

    la $a0, preamble
    jal print_str

    jr $t0


    mo_case: la $a0, monday
        jal print_str
        j end_switch
    tu_case: la $a0, tuesday
        jal print_str
        j end_switch
    we_case: la $a0, wednesday
        jal print_str
        j end_switch
    th_case: la $a0, thursday
        jal print_str
        j end_switch
    fr_case: la $a0, friday
        jal print_str
        j end_switch 
    sa_case: la $a0, saturday
        jal print_str
        j end_switch 
    su_case: la $a0, sunday
        jal print_str
    end_switch: li $v0, 10 
    syscall

.end main



.data

prompt:    .asciiz   "Enter the day of the week (1-7): "
monday:    .asciiz   "Monday"
tuesday:   .asciiz   "Tuesday"
wednesday: .asciiz   "Wednesday"
thursday:  .asciiz   "Thursday"
friday:    .asciiz   "Saturday"
saturday:  .asciiz   "Friday"
preamble:   .asciiz   "The day is "
# this also could of been done via a array of addresses to the day it likely would of simplified code
jump_table_print_day: 
    .word mo_case
    .word tu_case
    .word we_case
    .word th_case
    .word fr_case
    .word sa_case
    .word su_case
