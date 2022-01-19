[org 0x7C00]
[bits 16]

mov si, hello_world_string                      ; move the string address into si
mov ah, 0x0E                                    ; set teletype output mode

print_string:                                   ; print string label
    lodsb                                       ; load byte from si to al and increment pointer
    int 0x10                                    ; print_string al to screen
    test al, al                                 ; check if al is zero for zero terminated string
    jnz print_string                            ; if not keep printing

hello_world_string: db "Hello from assembly <3", 0

times 510-($ - $$) db 0
db 0x55, 0xAA