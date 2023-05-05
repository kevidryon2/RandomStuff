all: clean build/test.bin build/bxint

clean:
	rm -f build/*
	
build/test.bin: test.asm
	nasm test.asm -fbin -o build/test.bin

build/bxint: main.c
	gcc -g main.c -DDEBUG -o build/bxint
