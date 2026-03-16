.MODEL SMALL
.STACK 100H
.DATA
    objetivo_x DB 35      ; Posición X del objetivo
    objetivo_y DB 5       ; Posición Y del objetivo
    disparador_x DB 1     ; Posición X del disparador (esquina inferior izquierda)
    disparador_y DB 24    ; Posición Y del disparador (última fila)
    bala_x DB 0            ; Posición X de la bala
    bala_y DB 0            ; Posición Y de la bala
    bala_activa DB 0       ; Estado de la bala (0 = inactiva, 1 = activa)
    mensaje_ganar DB '¡Ganaste!$'
    mensaje_perder DB '¡Perdiste!$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Limpiar pantalla con color de fondo y bordes
    CALL LIMPIAR_PANTALLA

    ; Dibujar objetivo
    CALL DIBUJAR_OBJETIVO

    ; Dibujar disparador
    CALL DIBUJAR_DISPARADOR

BUCLE_PRINCIPAL:
    ; Verificar si la bala está activa
    CMP bala_activa, 1
    JE MOVER_BALA

    ; Leer entrada del teclado
    CALL LEER_TECLADO
    JZ BUCLE_PRINCIPAL  ; Si no hay tecla presionada, continuar el bucle

    ; Mover disparador a la izquierda
    CMP AH, 4BH  ; Código de la flecha izquierda
    JE MOVER_IZQUIERDA

    ; Mover disparador a la derecha
    CMP AH, 4DH  ; Código de la flecha derecha
    JE MOVER_DERECHA

    ; Disparar
    CMP AH, 48H  ; Código de la flecha arriba
    JE DISPARAR

    JMP BUCLE_PRINCIPAL

MOVER_IZQUIERDA:
    ; Mover disparador a la izquierda
    CMP disparador_x, 1
    JLE BUCLE_PRINCIPAL
    CALL BORRAR_DISPARADOR  ; Borrar disparador en la posición actual
    DEC disparador_x        ; Mover a la izquierda
    CALL DIBUJAR_DISPARADOR ; Dibujar disparador en la nueva posición
    JMP BUCLE_PRINCIPAL

MOVER_DERECHA:
    ; Mover disparador a la derecha
    CMP disparador_x, 78
    JGE BUCLE_PRINCIPAL
    CALL BORRAR_DISPARADOR  ; Borrar disparador en la posición actual
    INC disparador_x        ; Mover a la derecha
    CALL DIBUJAR_DISPARADOR ; Dibujar disparador en la nueva posición
    JMP BUCLE_PRINCIPAL

DISPARAR:
    ; Activar la bala
    CMP bala_activa, 0
    JNE BUCLE_PRINCIPAL
    MOV bala_activa, 1
    MOV AL, disparador_x
    MOV bala_x, AL
    MOV AL, disparador_y
    DEC AL
    MOV bala_y, AL
    JMP BUCLE_PRINCIPAL

MOVER_BALA:
    ; Mover la bala hacia arriba
    DEC bala_y
    CMP bala_y, 0
    JL PERDER_JUEGO  ; Si la bala sale de la pantalla, perder

    ; Dibujar la bala
    CALL DIBUJAR_BALA

    ; Verificar colisión
    MOV AL, bala_x
    CMP AL, objetivo_x
    JNE BUCLE_PRINCIPAL
    MOV AL, bala_y
    CMP AL, objetivo_y
    JNE BUCLE_PRINCIPAL

    ; Ganar
    CALL GANAR_JUEGO
    JMP SALIR_JUEGO

PERDER_JUEGO:
    ; Mostrar mensaje de derrota
    CALL LIMPIAR_PANTALLA
    CALL CAMBIAR_COLOR_FILA_VERDE  ; Cambiar color de la fila a verde
    MOV AH, 09H
    LEA DX, mensaje_perder
    INT 21H
    JMP SALIR_JUEGO

GANAR_JUEGO:
    ; Mostrar mensaje de victoria
    CALL LIMPIAR_PANTALLA
    CALL CAMBIAR_COLOR_FILA_VERDE  ; Cambiar color de la fila a verde
    MOV AH, 09H
    LEA DX, mensaje_ganar
    INT 21H
    JMP SALIR_JUEGO

SALIR_JUEGO:
    ; Salir al DOS
    MOV AX, 4C00H
    INT 21H

MAIN ENDP

; Procedimiento para limpiar la pantalla con color de fondo y bordes
LIMPIAR_PANTALLA PROC
    ; Limpiar la primera fila con color rojo
    MOV AH, 06H
    MOV AL, 0
    MOV BH, 4EH  ; Fondo rojo (4), texto amarillo (E)
    MOV CX, 0000H  ; Fila 0, columna 0
    MOV DX, 004FH  ; Fila 0, columna 79
    INT 10H

    ; Limpiar el resto de la pantalla con fondo amarillo, excepto las últimas dos filas
    MOV AH, 06H
    MOV AL, 0
    MOV BH, 1EH  ; Fondo amarillo (1), texto azul (E)
    MOV CX, 0100H  ; Fila 1, columna 0
    MOV DX, 164FH  ; Fila 22, columna 79
    INT 10H

    ; Limpiar las últimas dos filas sin color (fondo negro)
    MOV AH, 06H
    MOV AL, 0
    MOV BH, 00H  ; Fondo negro, texto negro
    MOV CX, 1700H  ; Fila 23, columna 0
    MOV DX, 184FH  ; Fila 24, columna 79
    INT 10H

    RET
LIMPIAR_PANTALLA ENDP

; Procedimiento para cambiar el color de la fila actual a verde
CAMBIAR_COLOR_FILA_VERDE PROC
    ; Obtener la posición actual del cursor (fila)
    MOV AH, 03H
    INT 10H
    MOV AL, DH  ; DH contiene la fila actual

    ; Cambiar el color de la fila actual a verde
    MOV AH, 06H
    MOV AL, 0
    MOV BH, 2EH  ; Fondo verde (2), texto amarillo (E)
    MOV CH, DH   ; Fila actual
    MOV CL, 0    ; Columna 0
    MOV DH, DH   ; Fila actual
    MOV DL, 79   ; Columna 79
    INT 10H

    RET
CAMBIAR_COLOR_FILA_VERDE ENDP

; Procedimiento para dibujar el objetivo
DIBUJAR_OBJETIVO PROC
    MOV AH, 02H
    MOV BH, 00H
    MOV DH, objetivo_y
    MOV DL, objetivo_x
    INT 10H
    MOV AH, 09H
    MOV AL, 0DBH
    MOV BH, 00H
    MOV BL, 22H  ; Color verde
    MOV CX, 1
    INT 10H
    RET
DIBUJAR_OBJETIVO ENDP

; Procedimiento para dibujar el disparador
DIBUJAR_DISPARADOR PROC
    ; Dibujar la base horizontal (3 cuadros)
    MOV AH, 02H
    MOV BH, 00H
    MOV DH, disparador_y
    MOV DL, disparador_x
    DEC DL
    INT 10H
    MOV AH, 09H
    MOV AL, 0DBH
    MOV BH, 00H
    MOV BL, 44H  ; Color rojo
    MOV CX, 3
    INT 10H

    ; Dibujar el cuadro central arriba
    MOV AH, 02H
    MOV BH, 00H
    MOV DH, disparador_y
    DEC DH
    MOV DL, disparador_x
    INT 10H
    MOV AH, 09H
    MOV AL, 0DBH
    MOV BH, 00H
    MOV BL, 44H  ; Color rojo
    MOV CX, 1
    INT 10H
    RET
DIBUJAR_DISPARADOR ENDP

; Procedimiento para borrar el disparador
BORRAR_DISPARADOR PROC
    ; Borrar la base horizontal (3 cuadros)
    MOV AH, 02H
    MOV BH, 00H
    MOV DH, disparador_y
    MOV DL, disparador_x
    DEC DL
    INT 10H
    MOV AH, 09H
    MOV AL, ' '
    MOV BH, 00H
    MOV BL, 00H
    MOV CX, 3
    INT 10H

    ; Borrar el cuadro central arriba
    MOV AH, 02H
    MOV BH, 00H
    MOV DH, disparador_y
    DEC DH
    MOV DL, disparador_x
    INT 10H
    MOV AH, 09H
    MOV AL, ' '
    MOV BH, 00H
    MOV BL, 00H
    MOV CX, 1
    INT 10H
    RET
BORRAR_DISPARADOR ENDP

; Procedimiento para dibujar la bala
DIBUJAR_BALA PROC
    ; Dibujar la bala
    MOV AH, 02H
    MOV BH, 00H
    MOV DH, bala_y
    MOV DL, bala_x
    INT 10H
    MOV AH, 09H
    MOV AL, 0DBH
    MOV BH, 00H
    MOV BL, 55H  ; Color magenta
    MOV CX, 1
    INT 10H

    ; Borrar la posición anterior de la bala
    CMP bala_y, 24
    JGE NO_BORRAR
    MOV AH, 02H
    INC DH
    INT 10H
    MOV AH, 09H
    MOV AL, ' '
    MOV BH, 00H
    MOV BL, 00H
    MOV CX, 1
    INT 10H
NO_BORRAR:
    RET
DIBUJAR_BALA ENDP

; Procedimiento para leer el teclado
LEER_TECLADO PROC
    MOV AH, 01H
    INT 16H
    JZ NO_TECLA  ; Si no hay tecla presionada, retornar
    MOV AH, 00H
    INT 16H
    RET
NO_TECLA:
    XOR AH, AH  ; Retornar 0 si no hay tecla presionada
    RET
LEER_TECLADO ENDP

END MAIN