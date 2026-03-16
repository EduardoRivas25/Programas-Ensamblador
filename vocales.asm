.MODEL SMALL
.STACK   
.DATA
   cadena db 20 dup(" "),"$"
    num equ $-cadena ;obtiene tamano cadena
    mensajeTotal db 10,13,"tiene un total de vocales: $"
    mensajeIngreso db 10,13,"Ingrese la cadena: $"
    total db 0 
.CODE
 main PROC
   MOV AX, @DATA
   MOV DS, AX

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

   MOV SI,0
   MOV DX,0H
   MOV CX,num
   
   ciclo:
        MOV AL,cadena[SI]
        CMP AL,97d
        je va
        CMP AL,101d
        je va
        CMP AL,105d
        je va
        CMP AL,111d
        je va
        CMP AL,117d
        je va
        CMP AL,65d
        je va
        CMP AL,69d
        je va
        CMP AL,73d
        je va
        CMP AL,79d
        je va
        CMP AL,85d
        je va
        
        regresa:
        inc SI
        loop ciclo
        JMP imprimir
        va:
        inc total
        jmp regresa

        imprimir:
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

        JMP FIN

        FIN:
        MOV AX,4C00H
        INT 21h


 main ENDP
END