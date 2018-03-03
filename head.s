	.code16
	.globl _head
	.data
gdtdesc:
	.word	0x17
	.long	gdt
gdt:
	/*dummy*/
	.word	0, 0
	.byte	0, 0, 0, 0

	/*32bit code */
	.word	0xffff, 0
	.byte	0, 0x9a, 0xcf, 0

	/*32bit data */
	.word	0xffff, 0
	.byte	0, 0x92, 0xcf, 0

	.text
_head:
	movb	$0x13, %al
	movb	$0x00, %ah
	int	$0x10

real_to_prot:
	cli
	xorw	%ax, %ax
	movw	%ax, %ds
	call	enable_a20	
	DATA32	ADDR32	lgdt	gdtdesc
	movl	%cr0, %eax
	andl	$0x7fffffff, %eax
	orl	$0x01, %eax
	movl	%eax, %cr0
	sti
	DATA32	ljmp $0x8, $protcseg

enable_a20:
	/* disable key board */
	call	wait_out_ready
	movb	$0xad, %al
	outb	$0x64

	call	wait_out_ready
	movb	$0xd1, %al
	outb	$0x64

	call	wait_out_ready
	movb	$0xdf, %al
	outb	$0x64

	/* read outport */
//	call	wait_out_ready
//	movb	$0xd0, %al
//	outb	$0x64
//
//	call	wait_out_ready
//	inb	$0x60
//
//	/* enable a20 */
//	call	wait_in_ready
//	orb	$0x2, %al
//	pushl	%eax
//	movb	$0xd1, %al
//	outb	$0x64
//
//	call	wait_out_ready
//	popl	%eax
//	outb	$0x60

	/* enable key board */
	call	wait_out_ready
	movb	$0xad, %al
	outb	$0x64

	call	wait_out_ready
	ret

wait_in_ready:
	inb	$0x64
	testb	$0x1, %al

	jnz	wait_in_ready
	ret

wait_out_ready:
	inb	$0x64
	testb	$0x2, %al

	jnz	wait_out_ready
	ret

	.code32
protcseg:
	cli
	movw	$0x10, %ax
	movw	%ax, %ds
	movw	%ax, %ss
	movw	%ax, %es
	movw	%ax, %fs
	movw	%ax, %gs
	movl	$0xffffffff, %esp 

	hlt
	
