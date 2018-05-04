MODEL small
  .STACK 100h

  INCLUDE procs.inc

  LOCALS

  .DATA
    inicio    db  "Inicio de conversion ",0
    seleccion db  "Seleccione base a convertir: ",0
    inloop    db  "Dentro de loop",0
    final     db  "Final de conversion",0
    new_line  db  13, 10, 0
    base      db 2
    decimal   dw  17
  .CODE

  Principal PROC
            mov ax, @DATA
            mov ds, ax
            call clrscr

            mov dx, offset inicio
            call puts

            mov dx, offset new_line
            call puts

            call printNumBase
            mov dx, offset new_line
            call puts

            mov dx, offset final
            call puts

            mov ah, 04ch
            mov al,0
            int 21h
            ret
            ENDP
            ;--Procedimientos--
  printNumBase  PROC
            mov ax, decimal
            mov bl, base
            mov bh,0
@@initLoop: div bl
            mov cx, ax
            ;Imprime contenidos de al almacenados en cl
            ;mov  ah, 02h
            ;mov  dl, ch    ;enviamos ax->cl a dl para desplegar en pantalla
            ;add  dl, "0"   ; Make into a character
            ;int  21h
            ;guardamos el residuo
            mov al,cl
            mov cl,ch
            mov ch,0
            push cx
            ;comparo si divisor es 0
            mov ah,0
            inc bh
            cmp ax,0
            jne @@initLoop
            ;impresion de valor base nueva
@@impLoop:  pop cx
            dec bh
            ;Imprime contenidos de al almacenados en cl
            mov  ah, 02h
            mov  dx, cx    ;enviamos ax->cl a dl para desplegar en pantalla
            add  dx, "0"   ; Make into a character
            int  21h
            cmp bh,0
            jne @@impLoop
            ;imprime nueva linea, mejor visualizacion
            mov dx, offset new_line
            call puts
            ;imprime el estado de loop
            mov dx, offset inloop
            call puts
            ;salida de proceso
            ret
            ENDP
  END
