all: clean build/qrin.png

clean:
	rm -f build/*

build/qrin: main.s
	nasm main.s -felf32 -o build/qrin.o
	nasm main.s -o build/qrin.com
	#nasm main.s -felf64 -o build/qrin64.o
	ld build/qrin.o -m elf_i386 -N -o build/qrin
	#d build/qrin64.o -m elf_x86_64 -N -o build/qrin64
	#strip build/qrin -R.got -R.data -R.comment -R.eh_frame -R.eh_frame_hdr -R.init_array -R.fini_array -R.fini -R.plt -R.init -R.gnu_version -R.gnu.hash -R.note*
	wc -c build/*

build/qrin.png: build/qrin
	qrencode --verbose -8r build/qrin -o build/qrin.png
	qrencode --verbose -8r build/qrin.com -o build/qrincom.png
