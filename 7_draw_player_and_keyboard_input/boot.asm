[org 0x7C00]
[bits 16]

KERNEL_OFFSET: equ 0x500 ; right after the BIOS data

; clean the systems state for good measure
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7C00

mov [boot_disk], dl                             ; save the boot disks index

mov si, disk_read_string                        ; move string pointer to source index
mov ah, 0x0E                                    ; set teletype mode

print_read_message:
    lodsb                                       ; load byte from si to al and increment pointer
    int 0x10                                    ; print_read_message al to screen
    test al, al                                 ; check if al zero for zero terminated string
    jnz print_read_message                      ; if not keep printing


; load the second sector from disk where our string is stored

mov bx, KERNEL_OFFSET                           ; bx = address to write the kernel to
mov al, 1                                       ; al = amount of sectors to read
mov ch, 0                                       ; cylinder to read from
mov dh, 0                                       ; head to read with
mov cl, 2                                       ; sectors are 1-index so we read the second sector
mov dl, [boot_disk]
mov ah, 2                                       ; ah = 2 notifies read from drive
int 0x13                                        ; call interrupt 

jmp KERNEL_OFFSET                               ; jump to the loaded kernel

boot_disk: db 0
disk_read_string: db "Trying to read kernel from sector 2", 0x0D, 0x0A, 0


times 510-($ - $$) db 0
db 0x55, 0xAA