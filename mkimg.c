#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <unistd.h>

int main()
{
	char str[2];
	int fd;

	fd = open("start.bin", O_RDWR, 0644);
	ftruncate(fd, 512);
	lseek(fd, 510, SEEK_SET);
	str[0] = 0x55;
	str[1] = 0xaa;
	write(fd, str, 2);
	close(fd);
}
