all: game.asm
	nasm -f elf game.asm;
	ld -m elf_i386 -s -o game game.o;
	./game;
	
clear:
	rm game.o;
	rm game;
