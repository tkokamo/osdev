LS=./ls


IPL=start.bin
OS=os.bin
IMG=tak.img

$(IPL) : start.s
	gcc start.s -nostdlib -T$(LS)/start.scr -o $(IPL)

$(OS) : head.s
	gcc head.s -nostdlib -T$(LS)/head.scr -o $(OS)

$(IMG) : $(IPL) $(OS)
	cat $(IPL) $(OS) > $(IMG)

clean :
	rm -f $(IPL) $(OS) $(IMG)


run : $(IMG)
	~/qemu-system-x86_64 -s -hda $(IMG) &
debug : $(IMG)
	~/qemu-system-x86_64 -s -S  -m 32 -localtime -vga std -hda $(IMG) -redir tcp:5555:127.0.0.1:1234 &

ipl:; make $(IPL)
os:; make $(OS)
img:; make $(IMG)
