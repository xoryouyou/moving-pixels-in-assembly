; sleep for cx:dx microseconds µs
; cx    | dx        |   seconds |   µs
; --------------------------------------------------
; 0xf   | 0x4240    |   1       |   1_000_000
; 0x7   | 0xa120    |   0.5     |   500_000
; 0x1   | 0x86a0    |   0.1     |   100_000
; 0x0   | 0x8235    |   0.033   |   33_333 (~30FPS)


; hardcoded for 0.1s sleep or ~10 loops per second
sleep:
    pusha               ; save all registers

    mov ah, 0x86        ; wait
    mov cx, 0x1         ; upper ms
    mov dx, 0x86a0      ; lower ms

    int 15h             ; call

    popa                ; restore all registers

    ret
