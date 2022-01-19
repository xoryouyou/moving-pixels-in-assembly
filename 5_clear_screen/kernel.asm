[org 0x1000]                                    ; note we need to tell nasm our code is loaded to 0x1000

mov si, hello_disk_string                       ; move the string address into si
mov ah, 0x0E                                    ; set teletype output mode

print_string:
    lodsb                                       ; load byte from si to al and increment pointer
    int 0x10                                    ; print_string al to screen
    test al, al                                 ; check if al zero for zero terminated string
    jnz print_string                            ; if not keep printing

mov ax, 0x13                                    ; set ah 0 and al 0x13
int 0x10                                        ; set video mode

mov ax, 0x0E                                    ; Yellow
mov cx, 5                                       ; x coordinate
mov dx, 15                                      ; y coordinate
call set_pixel                                  

call clear_screen                               ; clear the screen

mov ax, 0x02                                    ; green
mov cx, 50                                      ; x coordinate
mov dx, 50                                      ; y coordinate
call set_pixel

cli                                             ; clear all interrupts
hlt                                             ; halt the cpu    

; includes
%include "gfx.asm"
; new string
hello_disk_string: db "Hello from disk sector two <3", 0
; padding
times 512-($ - $$) db 0