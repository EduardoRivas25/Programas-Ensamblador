             .MODEL SMALL
.STACK   
.DATA
   cadena db 50 dup(" "),"$"
   cadena2 db 100 dup(" "),"$"
    num equ $-cadena 
    mensajeTotal db 10,13,"tiene un total de vocales: $"
    mensajeTotalA db 10,13,"tiene un total de A: $"
    mensajeTotalE db 10,13,"tiene un total de E: $"
    mensajeTotalI db 10,13,"tiene un total de I: $"
    mensajeTotalO db 10,13,"tiene un total de O: $"
    mensajeTotalU db 10,13,"tiene un total de U: $"
    mensajeIngreso db 10,13,"Ingrese la cadena: $"
    total db 0 
    A db 0
    E db 0
    I db 0
    O db 0
    U db 0
.CODE
IMPRIMIRM MACRO msg1
 MOV AH,09h
 LEA DX,msg1
 INT 21h
ENDM

 main PROC
   MOV AX, @DATA
   MOV DS, AX
   call PEDIR
   call Verificar
   call imprimir
PEDIR PROC
   MOV AH,09h
   LEA DX,mensajeIngreso
   int 21H

   MOV AH,3fh
   MOV BX,0
   MOV CX,20d
   MOV dx,OFFSET[cadena]
   int 21h

   MOV AH,02H
   MOV DL,10
   int 21h

   MOV AH,09h
   MOV DX,OFFSET[cadena]
   int 21H
PEDIR ENDP
 Verificar PROC
   MOV SI,0
   MOV DX,0H
   MOV CX,num
   MOV DI,0
   ciclo:
        MOV AL,cadena[SI]
        CMP AL,97d
        je va
        CMP AL,101d
        je ve
        CMP AL,105d
        je vi
        CMP AL,111d
        je vo
        CMP AL,117d
        je vu
        CMP AL,65d
        je va
        CMP AL,69d
        je ve
        CMP AL,73d
        je vi
        CMP AL,79d
        je vo
        CMP AL,85d
        je vu
        CMP AL,65d
        JB imprimir
        CMP AL,122d
        JA imprimir
        Mov cadena2[DI],AL
        INC DI
        regresa:
        inc SI
        loop ciclo
        JMP imprimir
        va:
        Mov cadena2[DI],AL
        inc DI
        Mov cadena2[DI],'f'
        INC DI
        Mov cadena2[DI],AL
        inc DI
        inc total
        inc A
        jmp regresa
    ve:
        Mov cadena2[DI],AL
        inc DI
        Mov cadena2[DI],'f'
        INC DI
        Mov cadena2[DI],AL
        inc DI
        inc total
        inc E
        jmp regresa
    vi:
        Mov cadena2[DI],AL
        inc DI
        Mov cadena2[DI],'f'
        INC DI
        Mov cadena2[DI],AL
        inc DI
        inc total
        inc I
        jmp regresa
    vo:
        Mov cadena2[DI],AL
        inc DI
        Mov cadena2[DI],'f'
        INC DI
        Mov cadena2[DI],AL
        inc DI
        inc total
        INC O
        jmp regresa
    vu:
        Mov cadena2[DI],AL
        inc DI
        Mov cadena2[DI],'f'
        INC DI
        Mov cadena2[DI],AL
        inc DI
        inc total
        INC U
        jmp regresa
Verificar ENDP
 imprimir PROC
        MOV AL,total
        AAM
        mov bx,ax
        add bx,3030h

        MOV AH,09H
        LEA DX,mensajeTotal
        INT 21H

        MOV AH,02H
        MOV DL,BH
        int 21H

        MOV AH,02H
        MOV DL,BL
        int 21H
    IMPRIMIR2:

        LEA DX,cadena2
        MOV AH,09h
        int 21h
        ;A
        IMPRIMIRM mensajeTotalA
        MOV AH,02h
        MOV DL,A
        ADD DL,30h
        INT 21h
        ;E
        IMPRIMIRM mensajeTotalE
        MOV AH,02h
        MOV DL,E
        ADD DL,30h
        INT 21h
        ;I
        IMPRIMIRM mensajeTotalI
        MOV AH,02h
        MOV DL,I
        ADD DL,30h
        INT 21h
        ;O
        IMPRIMIRM mensajeTotalO
        MOV AH,02h
        MOV DL,O
        ADD DL,30h
        INT 21h
        ;U
        IMPRIMIRM mensajeTotalU
        MOV AH,02h
        MOV DL,U
        ADD DL,30h
        INT 21h
        JMP FIN
imprimir ENDP
        FIN:
        MOV AX,4C00H
        INT 21h


 main ENDP
END