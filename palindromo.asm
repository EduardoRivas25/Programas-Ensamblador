.MODEL SMALL
.STACK
.DATA
    cad1 db 100 dup(" "),"$"
    cad2 db 100 dup(" "),"$"
    cad3 db 100 dup(" "),"$"
    cad4 db 100 dup(" "),"$"
    mensajeEs db 10,13,'Es Palindromo $'
    mensajeNoEs db 10,13,'No es Palindromo $'
    conta db 0
    tamcad db 0
    tamcad_sin_espacios db 0
.CODE
    MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    MOV AH, 3fh ;leer la cadena
    MOV BX, 00H ;empezar en 0
    MOV CX, 100 ;cuantos va a leer
    MOV DX, OFFSET [cad1] ;digo donde se va a guardar
    INT 21H

    LEA SI, cad1
CONTAR_CARACTERES:
    MOV CL, [SI]
    CMP CL, 13
    JE FIN_CONTAR
    INC tamcad
    INC SI
    JMP CONTAR_CARACTERES
FIN_CONTAR:

    LEA SI, cad1
    LEA DI, cad2
COPIAR_CADENA:
    MOV AL, [SI]
    CMP AL, 13
    JE FIN_COPIAR
    MOV [DI], AL
    INC DI
    INC SI
    JMP COPIAR_CADENA
FIN_COPIAR:

    LEA SI, cad2
    LEA DI, cad1
    MOV CL, tamcad
    ADD DI, CX
    DEC DI
INVERTIR_CADENA:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    DEC DI
    LOOP INVERTIR_CADENA

    MOV AH, 09H
    MOV DX, OFFSET [cad1]
    INT 21H

    LEA SI, cad1
    LEA DI, cad3
COPIAR_SIN_ESPACIOS:
    MOV AL, [SI]
    CMP AL, 13
    JE FIN_COPIAR_SIN_ESP
    CMP AL, 32
    JE SALTAR_ESPACIO
    CMP AL,9
    
    MOV [DI], AL
    INC DI
    INC tamcad_sin_espacios
SALTAR_ESPACIO:
    INC SI
    JMP COPIAR_SIN_ESPACIOS
FIN_COPIAR_SIN_ESP:

    LEA SI, cad3
    LEA DI, cad4
    MOV CL, tamcad_sin_espacios
    ADD DI, CX
    DEC DI
INVERTIR_SIN_ESP:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    DEC DI
    LOOP INVERTIR_SIN_ESP

    LEA SI, cad3
    LEA DI, cad4
    MOV CL, tamcad_sin_espacios
COMPARAR_CADENAS:
    MOV AL, [SI]
    MOV BL, [DI]
    CMP AL, BL
    JNE NO_ES_PALINDROMO
    INC SI
    INC DI
    LOOP COMPARAR_CADENAS

    MOV AH, 09H
    LEA DX, mensajeEs
    INT 21H
    JMP SALIR

NO_ES_PALINDROMO:
    MOV AH, 09H
    LEA DX, mensajeNoEs
    INT 21H

SALIR:
    MOV AX, 4C00H
    INT 21H
ENDP MAIN
END MAIN