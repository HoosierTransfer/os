org 0x0
bits 16

test: TIMES 9 DW 0

%define ENDL 0x0D, 0x0A
; lea edi, msg_hello
; sub	ecx, ecx
; sub	al, al
; not	ecx
; cld
; repne	scasb
; not	ecx
; dec	ecx
; movsx ecx, di

; lea di, msg_hello
; lea si, text
; mov cx, 1
; push ds
; pop es
; cld
; rep movsb
mov si, msg_hello
call puts
mov dl, 0
mov ax, 0
main:
    mov ah, 00h
    int 16h
    movsx ax, al
    push ax
    cmp ah, 0x1c
    je enterPressed
    cmp ah, 0x0e
    je backspacePressed
    mov [text], al
    mov ah, 0x0e
    mov bh, 0  
    mov bl, 4
    mov cx, 1
    int 10h
    cmp al, 5ch


    ; lea di, text_old
    ; add di, ax
    ; lea si, text
    ; mov cx, 1
    ; push ds
    ; pop es
    ; cld
    ; movsb
    ; mov si, text_old
    ; call puts

    jmp main


.halt:
    cli
    hlt

enterPressed:
    mov si, msg_Enter
    call puts
    jmp addCommand

backspacePressed:
    mov al, 0x08
    mov ah, 0x0e
    mov bh, 0
    mov bl, 4
    mov cx, 1
    int 10h ;go back 1 character
    mov al, 0x20 ;asii character for space
    int 10h ; print space
    mov al, 0x08 ; ascii character for backspace
    int 10h ;go back 1 character
    jmp main
puts:

    push si
    push ax
    push bx

.loop:
    lodsb               
    or al, al           
    jz .done

    mov ah, 0x0E        
    mov bh, 0           
    int 0x10

    jmp .loop

.done:
    pop bx
    pop ax
    pop si    
    ret 

keyPressed:
    mov ah,0
    int 16h
    jmp main

addCommand:
    pop ax
    pop cx
    pop dx
    pop cx
    pop bx
    cmp bx, 'd'
    jne main
    pop bx
    cmp bx, 'd'
    jne main
    pop bx
    cmp bx, 'a'
    jne main
    add ax, dx
    mov si, ax
    call puts
    jmp main

msg_hello: db 'Loading...', ENDL, 0
msg_Enter: db '', ENDL, 0
text: db '', ENDL, 0
text_old: db '', ENDL, 0