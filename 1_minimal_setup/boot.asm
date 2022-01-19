mov ah, 0x0E     ; setup for "teleype output"
mov al, 'h'      ; load character 'h'
int 0x10        ; call the interrup

times 510 - ( $ - $$ ) db 0

db 0x55, 0xAA