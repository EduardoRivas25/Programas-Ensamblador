.MODEL SMALL       
.STACK             
.DATA
    
    msg1 db 13, 10, 'Ingrese el primer numero (maximo 3 digitos): $'
    msg2 db 13, 10, 'Ingrese el segundo numero (maximo 3 digitos): $'
    msg3 db 13, 10, 'Seleccione una operacion:', 13, 10
         db '1. Suma', 13, 10
         db '2. Resta', 13, 10
         db '3. Multiplicacion', 13, 10
         db '4. Division', 13, 10
         db 'Opcion: $'
    msg4 db 13, 10, 'El resultado es: $'
    msg_error db 13, 10, 'Error: Maximo 3 digitos permitidos.', 13, 10, '$'
    msg_repetir db 13, 10, '¿Desea realizar otra operacion? (S/N): $'
    msg_decimal db '.$'

    ; Variables para almacenar números y resultados
    num1 dw ?       ; Primer número ingresado
    num2 dw ?       ; Segundo número ingresado
    result dw ?     ; Resultado de la operación
    op db ?         ; Operación seleccionada (1-4)
    repetir db ?    ; Variable para almacenar la respuesta del usuario
    decimal db ?    ; Variable para almacenar el decimal en la división

.CODE

; Macro para leer números de hasta 3 dígitos
READ_NUMBER MACRO
    LOCAL READ_LOOP, END_READ, ERROR  ; Etiquetas locales
    MOV CX, 0       ; Inicializa CX para almacenar el número
    MOV BX, 10      ; Base decimal para conversión
    MOV SI, 0       ; Contador de dígitos ingresados

READ_LOOP:
    MOV AH, 01H     ; Función de lectura de caracter
    INT 21H         ; Lee un dígito
    CMP AL, 0DH     ; Compara con Enter (ASCII 13)
    JE END_READ     ; Si es Enter, termina
    
    ; Verificar si ya se ingresaron 3 dígitos
    INC SI          ; Incrementa el contador de dígitos
    CMP SI, 3       ; Compara con 3
    JG ERROR        ; Si es mayor, muestra error
    
    SUB AL, '0'     ; Convierte ASCII a número (ej: '5' -> 5)
    MOV AH, 0       ; Limpia AH

    MOV DX, CX      ; Guarda CX en DX (temporal)
    MOV CX, AX      ; Mueve AX a CX
    MOV AX, DX      ; Recupera el valor original de CX en AX

    MUL BX          ; Multiplica por 10 para desplazar dígitos
    ADD CX, AX      ; Suma el nuevo dígito 121
    JMP READ_LOOP   ; Repite

ERROR:
    ; Mostrar mensaje de error
    LEA DX, msg_error
    MOV AH, 09H
    INT 21H
    JMP INICIO

END_READ:
    MOV AX, CX      ; Guarda el resultado final en AX
ENDM

; Macro para imprimir números
PRINT_NUMBER MACRO num
    LOCAL PRINT_LOOP, PRINT_DIGIT  ; Etiquetas locales
    MOV AX, num     ; Carga el número a imprimir
    MOV CX, 0       ; Contador de dígitos
    MOV BX, 10      ; Divisor para separar dígitos

PRINT_LOOP:
    MOV DX, 0       ; Limpia DX para división
    DIV BX          ; Divide AX por 10 (DX:AX/BX)
    PUSH DX         ; Guarda el residuo (dígito)
    INC CX          ; Incrementa contador de dígitos
    CMP AX, 0       ; ¿Ya no hay más dígitos?
    JNE PRINT_LOOP  ; Si no, repite

PRINT_DIGIT:
    POP DX          ; Recupera dígito del stack
    ADD DL, '0'     ; Convierte número a ASCII
    MOV AH, 02H     ; Función para imprimir caracter
    INT 21H         ; Imprime el dígito
    LOOP PRINT_DIGIT; Repite para todos los dígitos
ENDM

; Programa principal
MAIN PROC
    MOV AX, @DATA   ; Carga dirección del segmento de datos
    MOV DS, AX      ; Inicializa DS con la dirección

INICIO:
    ; ========== Lectura del primer número ==========
    LEA DX, msg1    ; Carga dirección de msg1
    MOV AH, 09H     ; Función para imprimir cadena
    INT 21H         ; Muestra "Ingrese el primer numero..."
    READ_NUMBER     ; Invoca macro para leer número
    MOV num1, AX    ; Guarda el número en num1

    ; ========== Lectura del segundo número ==========
    LEA DX, msg2    ; Carga dirección de msg2
    MOV AH, 09H
    INT 21H         ; Muestra "Ingrese el segundo numero..."
    READ_NUMBER     ; Lee segundo número
    MOV num2, AX    ; Guarda en num2

MENU:
    ; ========== Selección de operación ==========
    LEA DX, msg3    ; Carga dirección de msg3
    MOV AH, 09H
    INT 21H         ; Muestra menú de operaciones
    MOV AH, 01H     ; Función para leer caracter
    INT 21H         ; Lee la opción (1-4)
    SUB AL, '0'     ; Convierte ASCII a número
    MOV op, AL      ; Guarda la opción

    ; ========== Lógica de operaciones ==========
    CMP op, 1
    JE SUMA         ; Salta si es 1 (Suma)
    CMP op, 2
    JE RESTA        ; Salta si es 2 (Resta)
    CMP op, 3
    JE MULTIPLICACION ; Salta si es 3 (Multiplicación)
    CMP op, 4
    JE DIVISION     ; Salta si es 4 (División)
    JG MENU         ; Si es mayor a 4, vuelve al menú

SUMA:
    MOV AX, num1    ; Carga primer número
    ADD AX, num2    ; Suma con el segundo
    MOV result, AX  ; Guarda resultado
    JMP MOSTRAR_RESULTADO

RESTA:
    MOV AX, num1
    SUB AX, num2    ; Resta num2 de num1
    MOV result, AX
    JMP MOSTRAR_RESULTADO

MULTIPLICACION:
    MOV AX, num1
    MUL num2        ; Multiplicación sin signo
    MOV result, AX
    JMP MOSTRAR_RESULTADO

DIVISION:
    MOV AX, num1    ; Carga num1 en AX
    MOV DX, 0000h      ; Limpia DX (dividendo de 32 bits: DX:AX)
    DIV num2        ; Divide DX:AX entre num2 (sin signo)
    MOV result, AX  ; Guarda el cociente en result

    ; Calcular un decimal
    MOV AX, DX      ; Mueve el residuo a AX
    MOV BX, 10      ; Multiplicar por 10 para obtener un decimal
    MUL BX
    DIV num2        ; Divide entre num2 para obtener el decimal
    MOV decimal, AL ; Guarda el decimal

MOSTRAR_RESULTADO:
    ; ========== Mostrar resultado ==========
    LEA DX, msg4    ; Carga mensaje de resultado
    MOV AH, 09H
    INT 21H         ; Muestra "El resultado es: "
    PRINT_NUMBER result ; Invoca macro para imprimir número

    ; Si es división, mostrar el decimal
    CMP op, 4
    JNE FINAL
    LEA DX, msg_decimal ; Carga el mensaje del punto decimal
    MOV AH, 09H
    INT 21H
    MOV DL, decimal
    ADD DL, '0'     ; Convierte el decimal a ASCII
    MOV AH, 02H
    INT 21H

FINAL:
    ; ========== Preguntar si desea repetir ==========
    LEA DX, msg_repetir ; Carga mensaje de repetir
    MOV AH, 09H
    INT 21H         ; Muestra "¿Desea realizar otra operacion? (S/N): "
    MOV AH, 01H     ; Función para leer caracter
    INT 21H         ; Lee la respuesta
    MOV repetir, AL ; Guarda la respuesta

    ; ========== Verificar respuesta ==========
    CMP repetir, 'S' ; Compara con 'S' (Sí)
    JE INICIO        ; Si es 'S', vuelve al inicio
    CMP repetir, 's' ; Compara con 's' (sí en minúscula)
    JE INICIO        ; Si es 's', vuelve al inicio

    ; ========== Finalizar programa ==========
FIN:
    MOV AH, 4CH     ; Función de terminación
    INT 21H         ; Retorna control al SO

MAIN ENDP
END MAIN