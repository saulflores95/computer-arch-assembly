MODEL small
  .STACK 100h

  INCLUDE procs.inc

  LOCALS

  .DATA
    mens_ascii  db  "AL desplegado en ASCII:        ",0
    mens_bin    db  "AL desplegado en Binario:      ",0
    mens_dec    db  "AL desplegado en Decimal:      ",0
    mens_hex    db  "AL desplegado en Hexadecimal:  ",0
    new_line    db  13, 10, 0

  .CODE

  Principal PROC
            mov ax, @DATA
            mov ds, ax
            call clrscr

            mov al, 7Bh
            mov dx, offset mens_ascii
            call puts
            call putchar

            mov dx, offset new_line
            call puts

            mov dx, offset mens_bin
            call puts
            call printBin

            mov dx, offset new_line
            call puts

            mov dx, offset mens_dec
            call puts
            call printDec

            mov dx, offset new_line
            call puts

            mov dx, offset mens_hex
            call puts
            call printHex

            mov ah, 04ch
            mov al,0
            int 21h
            ret
            ENDP
            ;--Procedimientos--
  printBin  PROC
            push ax       ;salvar registros a utilizar
            push cx
            mov cx, 8     ;inicializar conteo a 99
            mov ah, al    ;ah ser el registro a desplegar
     @@nxt: mov al, '0'   ;preparar a al para imprimir ASCII
            shl ah, 1     ;pasar el msb de ah a la bandera de acarreo
            adc al,0      ;sumar a al el valor del acarreo
            call putchar
            loop @@nxt    ;continuar con el proximo bit
            pop cx        ;Recuperar registros utilizados
            pop ax
            ret
            ENDP
  printDec  PROC
            push ax       ;salvar registro a utilizar
            push bx
            push cx
            push dx
            mov cx, 3     ;iniciar conteo a 3 cent - dec - unida
            mov bx, 100   ;iniciar con centenas
            mov ah, 0     ;asegurar ax = al
     @@nxt: mov dx, 0     ;asegurar dx = 0 para usar reg16
            div bx        ;dividir dx:ax entre bx
            add al, '0'   ;convertir cociente en ASCII
            call putchar  ;desplegar digito en pantalla
            mov ax, dx    ;pasar residuo dx a d
            push ax       ;salvar temporalmente ax
            mov dx, 0     ;ajustart divisor para nuevo digito
            mov ax, bx    ;la idea es:
            mov bx, 10    ;   bx = bx/10
            div bx
            mov bx, ax    ;pasar cociente aal bx para nuevo digito
            pop ax        ;Recupera ax
            loop @@nxt    ;proximo digito
            pop dx
            pop cx
            pop bx
            pop ax
            ret
            ENDP
  printHex  PROC
            push ax    ;salvar registros a utilizar
            push bx
            push cx
            mov ah,0    ;asegurrar AX = AL
            mov bl, 16
            div bl      ;dividir ax/16 --> cociente en AL y residuo AH
            mov cx, 2   ;Para imprimir dos digitos hexs
     @@nxt: cmp al,10   ;Verificar si conciente al es menor a 10
            jb @@print
            add al, 7
   @@print: add al,30h  ;Si es menos a 10 sumar 30h de lo contrario 37h
            call putchar
            mov al, ah  ;Pasa residual (AH) a AL para imprimirlo
            loop @@nxt  ;Proximo digito
            pop cx
            pop bx
            pop ax      ;Recupera registros utilizados
            ret
            ENDP
  END
