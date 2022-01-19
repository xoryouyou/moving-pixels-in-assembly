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

; set pixel directly in VGA memory
; al - color
; 
; cx - x
; dx - y
set_pixel_fast:
  
    push es                     ; save es
    push bx                     ; save bx
    push ax                     ; save ax
    

    mov ax, VGA_SEGMENT         ; prepare ES which can't be loaded directly
    mov es, ax

    mov ax, 320                 ; load multiplier 320
    imul dx                     ; get row offset  Y * 320
    add ax, cx                  ; add column offset Y * 320 + X
    mov bx, ax                  ; load total address offset in bx
    
    pop ax                      ; restore ax
    mov [es:bx], al             ; paint color in vga memory add offset

    pop bx                      ; restore bx
    pop es                      ; restore es

    ret


; clear screen with color from BL
clear_screen:

    push es                     ; save es
    mov ax, 0xA000              ; prepeare direct memory access to Video RAM
    mov es, ax                  ; move to es
    mov ax, 0                   ; start at top left pixel
                                ; top right 
                                ; 0 will put it in top left corner. 
                                ; 320 would be top right
                                ; 320 x 200 pixels -> center is 320 * 100 + 160

    mov di, ax                  ; load ax into destination
    mov al, bl
    mov cx, 64000               ; set counter to 320 * 200 pixels to draw
    rep stosb                   ; repeat storebyte instruction
    pop es                      ; restore es
    ret    