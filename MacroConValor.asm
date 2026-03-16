.MODEL SMALL
.STACK 100H

.DATA
    num1    DB ?
    num2    DB ?
    msg1    DB 10,13,'Ingrese primer numero (1-99): $'
    msg2    DB 10,13,'Ingrese segundo numero (1-99): $'
    msgRes  DB 10,13,'Resultado: $'
    msgErr  DB 10,13,'Error: Solo digitos 0-9$'
    msgCero DB 10,13,'Error: No se permite cero$'
    msgMenor DB 10,13,'Error: Primer numero debe ser mayor$'

.CODE
    division MACRO n1,n2
        MOV AL, n1
        MOV AH, 0
        DIV n2  
        MOV num1,AL
    ENDM

    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX

        CALL pedirNumero
        MOV num1, BL

    PedirSegundo:
        CALL pedirNumero
        MOV num2, BL

        CMP num2, 0
        JE ErrorCero

        MOV AL, num1
        CMP AL, num2
        JB ErrorMenor
        division num1,num2

        MOV AH, 09H
        LEA DX, msgRes
        INT 21H

        CALL mostrarDigito

        MOV AH, 4CH
        INT 21H

    ErrorCero:
        MOV AH, 09H
        LEA DX, msgCero
        INT 21H
        JMP PedirSegundo

    ErrorMenor:
        MOV AH, 09H
        LEA DX, msgMenor
        INT 21H
        JMP MAIN

    MAIN ENDP

    pedirNumero:
        MOV AH, 09H
        CMP num1, 0
        JAE MostrarMsg2
        LEA DX, msg1
        JMP MostrarMsg
    MostrarMsg2:
        LEA DX, msg2
    MostrarMsg:
        INT 21H

    LeerNum:
        MOV BX,0000h

        MOV AH, 01h
        INT 21h
        CMP AL, '0'
        JB Error
        CMP AL, '9'
        JA Error
        SUB AL, 30H
        MOV BL, AL

        MOV AH, 01h
        INT 21h
        CMP AL, 13
        JE FinPedir

        CMP AL, '0'
        JB Error
        CMP AL, '9'
        JA Error
        MOV BH,AL
        MOV AL, BL
        MOV AH, 10
        MUL AH
        MOV BL, AL
        MOV AL, BH
        SUB AL, 30H
        ADD BL, AL
        JMP FinPedir

    Error:
        MOV AH, 09H
        LEA DX, msgErr
        INT 21H
        JMP LeerNum

    FinPedir:
        RET

    mostrarDigito: 
        MOV AL, num1
        CMP AL, 10
        JB UnDigito
        AAM
        MOV BX, AX
        MOV DL, BH
        ADD DL, 30H
        MOV AH, 02h
        INT 21h
        MOV AL, BL
UnDigito:
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 02h
        INT 21h
        RET

END MAIN