	.file	"smooth_mod.c"
	.globl	sample
	.data
	.align 32
	.type	sample, @object
	.size	sample, 40
sample:
	.long	0
	.long	1072693248
	.long	0
	.long	1073741824
	.long	0
	.long	1072693248
	.long	0
	.long	1073741824
	.long	0
	.long	1072693248
	.globl	coeff
	.align 32
	.type	coeff, @object
	.size	coeff, 40
coeff:
	.long	0
	.long	1070596096
	.long	0
	.long	1071644672
	.long	0
	.long	1072693248
	.long	0
	.long	1071644672
	.long	0
	.long	1070596096
	.comm	result,40,32
	.text
	.globl	smooth
	.type	smooth, @function
smooth:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movl	%ecx, -60(%rbp)
	movl	$0, %eax
	movq	%rax, -16(%rbp)
	movl	$0, %eax
	movq	%rax, -24(%rbp)
	movl	$1, -4(%rbp)
	jmp	.L2
.L5:
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-48(%rbp), %rax
	movsd	(%rax), %xmm0
	xorpd	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	seta	%al
	testb	%al, %al
	je	.L3
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-48(%rbp), %rax
	movsd	(%rax), %xmm0
	movsd	-24(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -24(%rbp)
	jmp	.L4
.L3:
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-48(%rbp), %rax
	movsd	(%rax), %xmm1
	movsd	-24(%rbp), %xmm0
	subsd	%xmm1, %xmm0
	movsd	%xmm0, -24(%rbp)
.L4:
	addl	$1, -4(%rbp)
.L2:
	cmpl	$3, -4(%rbp)
	jle	.L5
	movq	-48(%rbp), %rax
	movsd	(%rax), %xmm0
	xorpd	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	seta	%al
	testb	%al, %al
	je	.L6
	movq	-48(%rbp), %rax
	movsd	(%rax), %xmm0
	addsd	-24(%rbp), %xmm0
	movsd	%xmm0, -16(%rbp)
	jmp	.L7
.L6:
	movq	-48(%rbp), %rax
	movsd	(%rax), %xmm1
	movsd	-24(%rbp), %xmm0
	subsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
.L7:
	movl	$4, -28(%rbp)
	movl	-28(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-48(%rbp), %rax
	movsd	(%rax), %xmm0
	xorpd	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	seta	%al
	testb	%al, %al
	je	.L8
	movl	-28(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-48(%rbp), %rax
	movsd	(%rax), %xmm0
	movsd	-16(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
	jmp	.L9
.L8:
	movl	-28(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-48(%rbp), %rax
	movsd	(%rax), %xmm1
	movsd	-16(%rbp), %xmm0
	subsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
.L9:
	movl	$0, -4(%rbp)
	jmp	.L10
.L20:
	cmpl	$0, -4(%rbp)
	je	.L11
	movl	-60(%rbp), %eax
	subl	$1, %eax
	cmpl	-4(%rbp), %eax
	jne	.L12
.L11:
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-56(%rbp), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	-40(%rbp), %rdx
	movq	(%rdx), %rdx
	movq	%rdx, (%rax)
	jmp	.L13
.L12:
	cmpl	$1, -4(%rbp)
	je	.L14
	movl	-60(%rbp), %eax
	subl	$2, %eax
	cmpl	-4(%rbp), %eax
	jne	.L15
.L14:
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-56(%rbp), %rax
	movl	$0, %edx
	movq	%rdx, (%rax)
	movl	$1, -8(%rbp)
	jmp	.L16
.L17:
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-56(%rbp), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	-56(%rbp), %rdx
	movsd	(%rdx), %xmm1
	movl	-4(%rbp), %edx
	subl	$2, %edx
	addl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	-40(%rbp), %rdx
	movsd	(%rdx), %xmm2
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	-48(%rbp), %rdx
	movsd	(%rdx), %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, (%rax)
	addl	$1, -8(%rbp)
.L16:
	cmpl	$3, -8(%rbp)
	jle	.L17
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-56(%rbp), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	-56(%rbp), %rdx
	movsd	(%rdx), %xmm0
	divsd	-24(%rbp), %xmm0
	movsd	%xmm0, (%rax)
	jmp	.L13
.L15:
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-56(%rbp), %rax
	movl	$0, %edx
	movq	%rdx, (%rax)
	movl	$0, -8(%rbp)
	jmp	.L18
.L19:
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-56(%rbp), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	-56(%rbp), %rdx
	movsd	(%rdx), %xmm1
	movl	-4(%rbp), %edx
	subl	$2, %edx
	addl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	-40(%rbp), %rdx
	movsd	(%rdx), %xmm2
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	-48(%rbp), %rdx
	movsd	(%rdx), %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, (%rax)
	addl	$1, -8(%rbp)
.L18:
	cmpl	$4, -8(%rbp)
	jle	.L19
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-56(%rbp), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	-56(%rbp), %rdx
	movsd	(%rdx), %xmm0
	divsd	-16(%rbp), %xmm0
	movsd	%xmm0, (%rax)
.L13:
	addl	$1, -4(%rbp)
.L10:
	movl	-4(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jl	.L20
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	smooth, .-smooth
	.section	.rodata
.LC1:
	.string	"%f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$5, %ecx
	movl	$result, %edx
	movl	$coeff, %esi
	movl	$sample, %edi
	call	smooth
	movl	$0, -4(%rbp)
	jmp	.L22
.L23:
	movl	-4(%rbp), %eax
	cltq
	movsd	result(,%rax,8), %xmm0
	movl	$.LC1, %eax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf
	addl	$1, -4(%rbp)
.L22:
	cmpl	$4, -4(%rbp)
	jle	.L23
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Gentoo 4.6.3 p1.13, pie-0.5.2) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
