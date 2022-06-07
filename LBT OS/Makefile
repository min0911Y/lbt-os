run:
	rm Loader.bin
	rm TEST.img
	rm TEST.bin
	nasm Loader.asm -o Loader.bin
	nasm kernel.asm -o kernel.bin
	#copy /b Loader.bin+TEST.bin TEST.img
	cat Loader.bin kernel.bin > index.img
	qemu-system-i386 -fda index.img
