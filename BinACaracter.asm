MostrarResultado MACRO
MOV AH, 09H
LEA DX, msg_resultado
INT 21H

MOV AH, 02H
MOV DL, valor_decimal
INT 21H
ENDM

PedirNumero MACRO
MOV AH, 09H
LEA DX, msg_ingreso
INT 21H
ENDM

.MODEL SMALL
.STACK
.DATA
msg_ingreso db 10,13,'Ingresa valor en binario: $'
msg_resultado db 10,13,'El valor es: $'
msg_error db 10,13, 'ERROR',10,13,'$'

binario db ?
valor_decimal db ?
contador_bits db 0
.CODE
inicio PROC
MOV AX, @DATA
MOV DS, AX

CALL SOLICITAR_NUMERO

MOV AH, 4CH
INT 21H
ENDP inicio

SOLICITAR_NUMERO PROC
PedirNumero

MOV binario, 128
MOV valor_decimal, 0
MOV CX, 8

Leer_Bit:
MOV AH, 01h
INT 21H
CMP AL, 0DH
JE Mostrar_Resultado
SUB AL, 30H

CMP AL, 1
JE BIT_UNO
CMP AL, 0
JNE Error_Ingreso
JMP CALCULAR

BIT_UNO:
MOV AL, valor_decimal
ADD AL, binario
MOV valor_decimal, AL

CALCULAR:
MOV AL, binario
MOV BL, 02H
MOV AH, 00h
DIV BL
MOV binario, AL
INC contador_bits
LOOP Leer_Bit

Mostrar_Resultado:
MostrarResultado
RET

Error_Ingreso:
MOV AH, 09H
LEA DX, msg_error
INT 21H
JMP SOLICITAR_NUMERO
ENDP SOLICITAR_NUMERO
END inicio

