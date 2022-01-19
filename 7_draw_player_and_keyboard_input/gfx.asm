set_pixel:
; set a pixel in mode 13
; ax - color
; bx - (defaults to 0)
; cx - x coordinate
; dx - y coordinate

    push ax                     ; save ax
    push bx                     ; save bx
    
    mov ah, 0x0C                ; int ah=0x0C write pixel 
    mov bh, 0                   ; page number
    int 0x10                    ; call interrupt

    pop bx                      ; restore bx
    pop ax                      ; restore ax
    ret

set_pixel_fast:
; set pixel directly in VGA memory
; al - color
; 
; cx - x
; dx - y

    push es                     ; save es
    push bx                     ; save bx
    push ax                     ; save ax

    mov ax, VGA_SEGMENT         ; prepare ax to move into es
    mov es, ax                  ; load es from ax since it can't be loaded directly

    mov ax, 320                 ; load multiplier 320
    imul dx                     ; get row offset  Y * 320
    add ax, cx                  ; add column offset Y * 320 + X
    mov bx, ax                  ; load total address offset in bx
    
    pop ax                      ; restore ax
    mov [es:bx], al             ; paint color in vga memory add offset

    pop bx                      ; restore bx
    pop es                      ; restore es

    ret


clear_screen:
; clear screen with color from BL

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

draw_player:
; helper function to draw a player pixel

    pusha                       ; save all registers

    mov ax, [player_color]      ; load color
    mov cx, [player_pos_x]      ; load x coordinate
    mov dx, [player_pos_y]      ; load y coordinate

    call set_pixel_fast         ; call draw function

    popa                        ; restore all registers
    ret