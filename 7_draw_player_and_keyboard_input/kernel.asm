[org 0x500]
[bits 16]

; memory offsets
VGA_SEGMENT:    equ 0xA000

; BIOS colors
COLOR_BLUE:     equ 0x01
COLOR_GREEN:    equ 0x02
COLOR_RED:      equ 0x04
COLOR_MAGENTA:  equ 0x05
COLOR_YELLOW:   equ 0x0E

mov si, hello_disk_string                       ; move string pointer to source index
mov ah, 0x0E                                    ; set teletype mode

print_read_message:
    lodsb                                       ; load byte from si to al and increment pointer
    int 0x10                                    ; print_read_message al to screen
    test al, al                                 ; check if al zero for zero terminated string
    jnz print_read_message                      ; if not keep printing
    
mov ax, 0x13                                    ; mode 13
int 0x10

game_loop:
    call clear_screen
    call draw_player
    call sleep
    
    ;;; input section ;;;
    mov ah, 1                           ; get state of keyboard buffer
    int 0x16                            ; call the interrupt
    jz game_loop                        ; if the buffer is empty got back to the top

    ; else some key got pressed
    mov ah, 0                           ; get the scancode of the pressed key
    int 0x16                            ; call the interrupt

    cmp al, 'a'                         ; check if 'a'-key was pressed
    je move_left                        ; move the player left

    cmp al, 'd'                         ; check if 'd'-key was pressed
    je move_right                       ; move the player right

    cmp al, 'w'                         ; check if 'w'-key was pressed
    je move_up                          ; move the player up

    cmp al, 's'                         ; check if 's'-key was pressed
    je move_down                        ; move the player down

    jmp game_loop                       ; if any other key was pressed ignore it
    
    ;;; player movement ;;;
    move_left:
        sub byte [player_pos_x], 1      ; subtract one from the x position
        jmp game_loop                   ; go back to the top

    move_right:
        add byte [player_pos_x], 1      ; add one to the x position
        jmp game_loop                   ; go back to the top

    move_up:
        sub byte [player_pos_y], 1      ; subtract one from the y position
        jmp game_loop                   ; go back to the top

    move_down:
        add byte [player_pos_y], 1      ; add one to the y position
        jmp game_loop                   ; go back to the top

; clear interrupts and halt the cpu
cli
hlt

; includes
%include "gfx.asm"
%include "time.asm"

; allocated memory
hello_disk_string:  db "Hello from disk sector two <3", 0
player_pos_x:       dw 150
player_pos_y:       dw 10
player_color:       dw COLOR_RED

; padding to full sector size
times 512-($ - $$) db 0