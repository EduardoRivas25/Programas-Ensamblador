.MODEL SMALL
.STACK 100H

.DATA
    msg1 db 10,13,"Ingrese numero (0-9): $"
    msgR db 10,13,"Suma: $"
    suma db 0
.CODE
IMPRIMIR_MENSAJE MACRO mensaje
    mov ah, 09h
    lea dx, mensaje
    int 21h
ENDM
LEER_DIGITO MACRO
    mov ah, 01h
    int 21h
    sub al, '0'
ENDM
IMPRIMIR_NUMERO MACRO
    cmp bl,10
    JB unDigito
    mov al,bl
    AAM
    mov bl,al
    mov dl,ah
    add dl,'0'
    mov ah,02h
    int 21h
    unDigito:
    mov dl,bl
    add dl,'0'
    mov ah,02h
    int 21h
ENDM
    mov ax, @data
    mov ds, ax

    IMPRIMIR_MENSAJE msg1
    LEER_DIGITO
    mov bl,al
    mov bh,0
    buclesuma:
    inc bh
    add suma,bh
    cmp bh,bl
    jb buclesuma
    mov bl,suma
    IMPRIMIR_MENSAJE msgR
    IMPRIMIR_NUMERO
    MOV AH, 4CH
    int 21h
END 