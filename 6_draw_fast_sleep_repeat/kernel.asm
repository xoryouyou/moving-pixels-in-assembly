[org 0x1000]                                    ; note we need to tell nasm our code is loaded to 0x1000

; memory offsets
VGA_SEGMENT:    equ 0xA000

; BIOS colors
COLOR_BLUE:     equ 0x01
COLOR_GREEN:    equ 0x02
COLOR_RED:      equ 0x04
COLOR_MAGENTA:  equ 0x05
COLOR_YELLOW:   equ 0x0E

mov si, hello_disk_string                       ; move the string address into si
mov ah, 0x0E                                    ; set teletype output mode

print_string:
    lodsb                                       ; load byte from si to al and increment pointer
    int 0x10                                    ; print_string al to screen
    test al, al                                 ; check if al zero for zero terminated string
    jnz print_string                            ; if not keep printing

mov ax, 0x13                                    ; set ah 0 and al 0x13
int 0x10                                        ; set video mode

game_loop:

    call clear_screen
    
    ; draw something
    mov ax, COLOR_MAGENTA                          
    mov cx, 50                                  ; x coordinate
    mov dx, 50                                  ; y coordinate
    call set_pixel_fast

    call sleep
    jmp game_loop                               ; back to the top

cli                                             ; clear all interrupts
hlt                                             ; halt the cpu    

; includes
%include "gfx.asm"
%include "time.asm"
; new string
hello_disk_string: db "Hello from disk sector two <3", 0
; padding
times 512-($ - $$) db 0