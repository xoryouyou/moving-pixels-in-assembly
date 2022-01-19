[org 0x7C00]
[bits 16]

KERNEL_OFFSET: equ 0x1000                       ; arbitrary offset in memory


mov [boot_disk], dl                             ; save the disk index

mov si, disk_read_string                        ; move string pointer to source index
mov ah, 0x0E                                    ; set teletype mode

print_read_message:
    lodsb                                       ; load byte from si to al and increment pointer
    int 0x10                                    ; print_read_message al to screen
    test al, al                                 ; check if al zero for zero terminated string
    jnz print_read_message                      ; if not keep printing


; load the second sector from disk where our code is stored

mov ah, 2                                       ; ah = 2 notifies read from drive
mov al, 1                                       ; al = amount of sectors to read
mov bx, KERNEL_OFFSET                           ; bx = address to write the kernel to
mov cl, 2                                       ; sectors are 1-index so we read the second sector
mov ch, 0                                       ; cylinder to read from
mov dh, 0                                       ; head to read with
mov dl, [boot_disk]                             ; restore disk index from variable
int 0x13                                        ; call interrupt 

jmp KERNEL_OFFSET                               ; jump to our loaded data and execute it


; variable to store boot drive index in
boot_disk: db 0
; message for debug purposes with a carriage return, line feed and null
disk_read_string: db "Trying to read kernel from sector 2", 0x0D, 0x0A, 0

; padding and boot signature
times 510-($ - $$) db 0
db 0x55, 0xAA