.MODEL SMALL
.STACK   
.DATA
   cadena db 50 dup(" "),"$"
   cadena2 db 100 dup(" "),"$"
   num equ $-cadena 
   mensajeTotal db 10,13,"Total de vocales originales: $"
   mensajeTotalA db 10,13,"Total de A: $"
   mensajeTotalE db 10,13,"Total de E: $"
   mensajeTotalI db 10,13,"Total de I: $"
   mensajeTotalO db 10,13,"Total de O: $"
   mensajeTotalU db 10,13,"Total de U: $"
   mensajeIngreso db 10,13,"Ingrese la cadena en idioma F: $"
   mensajeOriginal db 10,13,"Cadena original: $"
   mensajeTraducida db 10,13,"Cadena traducida: $"
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
   MOV AX,4C00H
   INT 21h
main ENDP

PEDIR PROC
   IMPRIMIRM mensajeIngreso

   MOV AH,3fh
   MOV BX,0
   MOV CX,50d          
   MOV dx,OFFSET[cadena]
   int 21h

   IMPRIMIRM mensajeOriginal
   IMPRIMIRM cadena
   RET
PEDIR ENDP

Verificar PROC
   MOV SI,0            
   MOV DI,0           
   MOV CX,50         

ciclo:
   MOV AL,cadena[SI]
   CMP AL,'$'          
   JE fin_ciclo
   
   CMP AL,97d          
   JE posible_vocal
   CMP AL,101d         
   JE posible_vocal
   CMP AL,105d         
   JE posible_vocal
   CMP AL,111d        
   JE posible_vocal
   CMP AL,117d         
   JE posible_vocal
   CMP AL,65d         
   JE posible_vocal
   CMP AL,69d          
   JE posible_vocal
   CMP AL,73d          
   JE posible_vocal
   CMP AL,79d          
   JE posible_vocal
   CMP AL,85d          
   JE posible_vocal
   
   MOV cadena2[DI],AL
   INC DI
   INC SI
   JMP ciclo

posible_vocal:
   MOV BL,cadena[SI+1] 
   CMP BL,'f'  
           
   JNE copiar_normal  
   
   MOV BL,cadena[SI+2] 
   CMP BL,AL           
   JNE copiar_normal   
   
   
   MOV cadena2[DI],AL
   INC DI
   
   INC total
   CMP AL,97d          
   JE va
   CMP AL,101d         
   JE ve
   CMP AL,105d         
   JE vi
   CMP AL,111d         
   JE vo
   CMP AL,117d         
   JE vu
   CMP AL,65d          
   JE va
   CMP AL,69d          
   JE ve
   CMP AL,73d         
   JE vi
   CMP AL,79d         
   JE vo
   CMP AL,85d          
   JE vu
   JMP avanzar

va:
   INC A
   JMP avanzar
ve:
   INC E
   JMP avanzar
vi:
   INC I
   JMP avanzar
vo:
   INC O
   JMP avanzar
vu:
   INC U

avanzar:
   ADD SI,3           
   JMP ciclo

copiar_normal:
   MOV cadena2[DI],AL
   INC DI
   INC SI
   JMP ciclo
fin_ciclo:
   MOV cadena2[DI],'$'
   RET
Verificar ENDP

imprimir PROC
   IMPRIMIRM mensajeTraducida
   IMPRIMIRM cadena2

   MOV AL,total
   AAM
   mov bx,ax
   add bx,3030h

   IMPRIMIRM mensajeTotal
   MOV AH,02H
   MOV DL,BH
   int 21H
   MOV AH,02H
   MOV DL,BL
   int 21H


   IMPRIMIRM mensajeTotalA
   MOV AH,02h
   MOV DL,A
   ADD DL,30h
   INT 21h

   IMPRIMIRM mensajeTotalE
   MOV AH,02h
   MOV DL,E
   ADD DL,30h
   INT 21h

   IMPRIMIRM mensajeTotalI
   MOV AH,02h
   MOV DL,I
   ADD DL,30h
   INT 21h

   IMPRIMIRM mensajeTotalO
   MOV AH,02h
   MOV DL,O
   ADD DL,30h
   INT 21h

   IMPRIMIRM mensajeTotalU
   MOV AH,02h
   MOV DL,U
   ADD DL,30h
   INT 21h
   RET
imprimir ENDP

END