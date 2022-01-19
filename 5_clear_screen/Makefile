parts = boot.bin kernel.bin

os.img: $(parts)
	cat $^ > os.img
	echo "Concatenating $^ to the final image"

%.bin: %.asm
	nasm -f bin $< -o $@
	echo "Building $@ from $<"

run: os.img
	qemu-system-x86_64 -drive format=raw,file=os.img

clean:
	rm $(parts) os.img