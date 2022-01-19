[org 0x1000]                                    ; note we need to tell nasm our code is loaded to 0x1000

mov si, hello_disk_string                       ; move the string address into si
mov ah, 0x0E                                    ; set teletype output mode

print_string:
    lodsb                                       ; load byte from si to al and increment pointer
    int 0x10                                    ; print_string al to screen
    test al, al                                 ; check if al zero for zero terminated string
    jnz print_string                            ; if not keep printing


cli                                             ; clear all interrupts
hlt                                             ; halt the cpu    

; new string
hello_disk_string: db "Hello from disk sector two <3", 0
; padding
times 512-($ - $$) db 0