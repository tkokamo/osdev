	.code16
	.globl _start

_start:
	cli
	ljmp	$0, $rstart
rstart:
	xorw	%ax, %ax
	movw	%ax, %ds
	movw	%ax, %ss	/* cannot mov imm to %ss */
	movw	$0x7c00, %sp
print_hello:
	lea	msg_hello, %si
	call	print
load_bt:
	movw	$0x0820, %ax
	movw	%ax, %es
	movb	$0x02, %ah
	movw	$0x00, %bx
	movb	$0x80, %dl
	movb	$0x00, %dh
	movb	$0x02, %cl
	movb	$0x00, %ch
	movb	$0x01, %al
	int	$0x13
//	jc	error
	sti
	hlt
print:
	movb	$0x0e, %ah
	movb	$0x0f, %bl
	movb	$0x00, %bh
print_loop:
	lodsb
	testb	%al, %al
	jz	print_end
	int	$0x10
	jmp	print_loop
print_end:
	ret
//	jmp	load_bt
//	pop	%ax
//	jmp	*%ax

msg_hello:
	.asciz	"Hello, world\r\n"
msg_error:
	.asciz	"Error has occurred\r\n"
