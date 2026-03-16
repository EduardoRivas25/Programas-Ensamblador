.MODEL SMALL
.STACK 100H
.DATA
    arr db 5 dup(0)
    m1 db "Ingrese los numeros: ",10,'$'
    m2 db 10,"Los numeros de la pila al reves son: ",10,'$'
    m3 db 10,"La suma de los numeros es: ",10,'$'
    mpar db 10,13,"Es par $"
    mimpar db 10,13,"No es Par $"
    suma db 0
    decena db 0
    unidad db 0
.CODE
    mov ax,@DATA
    mov ds,ax
    mov cl,03

    mov ah,09H
    mov dx,OFFSET m1
    int 21h

    ingresar:
        mov ah,01H
        int 21h
        sub al, 30h
        push ax
    loop ingresar

    mov ah,09H
    mov dx,OFFSET m2
    int 21h

    mov cl,03
    mov si,0

    sacar:
        pop ax
        mov arr[si],al
        inc si
        mov ah,02H
        mov dl,al
        add dl, 30h
        int 21h
    loop sacar

    mov cl,03
    mov si,0
    mov suma, 0
    sumando:
        mov al,arr[si]
        add suma,al
        inc si
    loop sumando

    mov ah,09H
    mov dx,OFFSET m3
    int 21h

    mov al,suma
    AAM
    mov decena,ah
    mov unidad,al
    
    cmp decena,0
    je mostrar_unidad
    
    mov ah,02H
    mov dl,decena
    add dl,30h
    int 21h
    
    mostrar_unidad:
    mov ah,02H
    mov dl,unidad
    add dl,30h
    int 21h

    mov al, suma
    and al, 1
    jz es_par
    
    mov ah,09H
    mov dx,OFFSET mimpar
    int 21h
    jmp salir
    
    es_par:
    mov ah,09H
    mov dx,OFFSET mpar
    int 21h

    salir:
        mov ah,4CH
        int 21h
END