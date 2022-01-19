; set a pixel in mode 13
; ax - color
; bx - (default) 0
; cx - x coordinate
; dx - y coordinate


set_pixel:

	push bx             ; save bx
	; automatic way - https://stanislavs.org/helppc/int_10-c.html
	mov ah, 0x0C        ; int 0x10 write pixel
	mov bh, 0           ; page number
	int 0x10            ; call interrupt

	pop bx              ; restore bx
	
	ret