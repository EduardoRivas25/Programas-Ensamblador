.MODEL SMALL
.STACK
.DATA

    totalAsteriscos DB 01h
    posFila db 00h
    posCoulna db 27h
    totalLineas db ?
    asterisco db 2ah
    
    mensaje db "Total Lineas: $"
    salirMensaje db 10,13, "Desea salir? (S/N): $"
    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    CALL LimpiarPantalla
    CALL DibujarPiramide
    CALL Salir

    INT 27H  
MAIN ENDP

; Procedimiento para limpiar la pantalla
LimpiarPantalla PROC
    MOV AH,07H
    MOV AL,00h
    MOV BH,07H
    MOV CH,00h
    MOV CL,00H
    MOV DH,19H
    MOV DL,54H
    INT 10H
    RET
LimpiarPantalla ENDP

; Procedimiento para dibujar la pirámide
DibujarPiramide PROC
    MOV AH,02H
    MOV BH,00H
    MOV DH,0AH
    MOV DL,15H
    INT 10H

    MOV AH,09H
    LEA DX,mensaje
    INT 21H

    MOV AH,01H
    INT 21H

    MOV totalLineas,AL
    SUB totalLineas,30H

    MOV CH,00h
    MOV totalAsteriscos,01h
    MOV posFila,00h
    MOV posCoulna,27h

    INICIO: 
        MOV AH,02H
        MOV BH,00h
        MOV DH,posFila
        MOV DL,posCoulna
        INT 10H

        MOV CL,00h
        IMPRIMIR:
            MOV AH,02H
            MOV DL,asterisco
            INT 21H
            ADD CL,01h
            CMP CL,totalAsteriscos
            JB IMPRIMIR

        ADD CH,01H
        ADD totalAsteriscos,02H
        ADD posFila,01h
        SUB posCoulna,01h

        CMP CH,totalLineas
        JB INICIO
    RET
DibujarPiramide ENDP

; Procedimiento para preguntar si se desea salir
Salir PROC
    MOV AH,09H
    LEA DX,salirMensaje
    INT 21H

    MOV AH,01H
    INT 21H

    CMP AL,'S'
    JE FIN
    CMP AL,'s'
    JE FIN

    CALL MAIN  ; Si el usuario no elige salir, se repite el programa

    FIN:
    RET
Salir ENDP

END MAIN