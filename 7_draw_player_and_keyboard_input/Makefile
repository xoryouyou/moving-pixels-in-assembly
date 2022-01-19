parts = boot.bin kernel.bin

os.img: $(parts)
	cat $^ > os.img
	echo "piping $^ to os image"

%.bin: %.asm
	nasm -f bin $< -o $@
	echo "building $@ from $<"

run: os.img
	qemu-system-x86_64 -drive format=raw,file=os.img

clean:
	rm $(parts) os.img