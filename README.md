# Moving pixels in assembly

This repo contains the source code for this blog post: [moving-pixels-in-assembly](https://tillvonahnen.de/blog/moving-pixels-in-assembly/)

## You need:

* `qemu` https://www.qemu.org/download/
* `make` (should come with most systems)
* `nasm` https://www.nasm.us/

## Structure

Each folder is selfcontained and represents a step towards the final source code to work along the blogpost.

Within the folder is a `Makefile` and the needed `.asm` files to build.

## Result

When everything works you should have a red pixel on your screen in `qemu`
which you can move around using the `WASD`-keys.

From here on get creative and build what you like! :)

![](.github/final.gif)
