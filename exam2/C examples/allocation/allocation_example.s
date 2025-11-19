# This code was generated from the C file in the same directory using the following command
# gcc -S allocation_example.c
# This uses the at&t syntax by default
# THIS IS NOT MIPS CODE


	.file	"allocation_example.c"
	.text
	.data
	.type	greeting, @object 
	.size	greeting, 3
greeting:	     # Greeting label/static address
	.string	"yo" # The string yo was allocated on the data segment
	.section	.rodata
.LC0:
	.string	"%s %s\n" 
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$1953658215, -13(%rbp)
	movb	$0, -9(%rbp)
	leaq	-13(%rbp), %rax
	movq	%rax, %rdx
	leaq	greeting(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$20, %edi
	call	malloc@PLT      # Allocating bytes on the heap via malloc 
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT	    # Freeing heap memory 
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L3
	call	__stack_chk_fail@PLT
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
