.MODEL SMALL
.STACK 100H

.DATA
    msg1 db 10,13,"Ingrese numero (0-9): $"
    msgR db 10,13,"Suma: $"
    suma db 0
.CODE
    mov ax, @DATA
    mov ds, ax

    call pedir_numero
    mov bl, al
    
    mov bh, 0
bucle_suma:
    inc bh
    add suma, bh
    cmp bh, bl
    jb bucle_suma

    lea dx,msgR
    call imprimir_msg
    mov al, suma
    aam
    mov bx, ax
    cmp bh, 0
    je solo_unidades
    mov dl, bh
    add dl, '0'
    mov ah, 02H
    int 21h

solo_unidades:
    mov dl, bl
    add dl, '0'
    mov ah, 02H
    int 21h
    mov ah, 4CH
    int 21h

pedir_numero PROC
    mov ah, 09H
    mov dx, OFFSET msg1
    int 21h
    
    mov ah, 01H
    int 21h
    sub al, '0'
    RET
pedir_numero ENDP

imprimir_msg PROC
    mov ah, 09H
    int 21h
    RET
imprimir_msg ENDP

END