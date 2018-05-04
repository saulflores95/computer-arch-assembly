MODEL small
  .STACK 100h

  INCLUDE procs.inc

  LOCALS

  .DATA
    inicio      db  "Ingrese un caracter [A-Z][a-z]",  0
    final       db  "Final de Programa", 0
    outrange    db  "Valor no esta en el rango acceptado",0
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
            call getAlpha

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
  getAlpha  PROC
            mov bx, dx
            mov si, 0
 @@capLoop: call getchar

            cmp al,13
            je @@exitProc

            cmp al, 'A'
            jl @@outoFRange

            cmp al, 'Z'
            jg @@lowercase

@@lowercase:
            cmp al, 'a'
            jae @@lowercaseLimit
@@lowercaseLimit:
            cmp al, 'z'
            jg @@outoFRange

            mov [bx+si], al
            inc si
            jmp @@capLoop
@@outoFRange :
            mov dx, offset new_line
            call puts
            mov dx, offset outrange
            call puts
            mov dx, offset new_line
            call puts
            jmp @@capLoop
@@exitProc: mov byte ptr [bx+si],0
            ret
            ENDP
  END
