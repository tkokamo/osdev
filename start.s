	.code16
	.globl _start

_start:
	lea	msg_hello, %si
	mov	$0x0e, %ah
	mov	$0x0f, %bl
	mov	$0x00, %bh
loop:
	lodsb
	test	%al, %al
	jz	end
	int	$0x10
	jmp	loop
end:
	ret

msg_hello:
	.asciz	"Hello, world\n"
