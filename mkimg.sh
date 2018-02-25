cmd="gcc -nostdlib -Ttext=0x7c00 start.s"
${cmd}
echo "${?} : ${cmd}" 
cmd="objcopy -j .text -I elf64-x86-64 -O binary a.out start.bin"
${cmd}
echo "${?} : ${cmd}"
cmd="./mkimg"
${cmd}
echo "${?} : ${cmd}" 


