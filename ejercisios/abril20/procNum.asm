MODEL small
  .STACK 100h

  INCLUDE procs.inc

  LOCALS

  .DATA
    inicio      db  "Ingrese un numero de 0-9:",  0
    final       db  "Final de Programa", 0
    valorMayor  db  "Valor es mayor al del rango acceptado",0
    valorMenor  db  "Valor es menor al del rango acceptado",0
    new_line    db  13, 10, 0,
    cadena      db  32 dup(?)

  .CODE

  Principal PROC
            mov ax, @DATA
            mov ds, ax
            call clrscr

            mov dx, offset inicio
            call puts

            mov dx, offset new_line
            call puts

            mov dx, offset cadena
            call getNum

            mov dx, offset cadena
            call puts

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
  getNum  PROC
            mov bx, dx
            mov si, 0
 @@capLoop: call getchar

            cmp al,13
            je @@exitProc

            cmp al, '9'
            jg @@rangeIsBigger

            cmp al, '0'
            jl @@rangeIsLower

            mov [bx+si], al
            inc si
            jmp @@capLoop
@@rangeIsBigger :
            mov dx, offset new_line
            call puts
            mov dx, offset valorMayor
            call puts
            mov dx, offset new_line
            call puts
            jmp @@capLoop
@@rangeIsLower :
            mov dx, offset new_line
            call puts
            mov dx, offset valorMenor
            call puts
            mov dx, offset new_line
            call puts
            jmp @@capLoop
@@exitProc: mov byte ptr [bx+si],0
            ret
            ENDP
  END
