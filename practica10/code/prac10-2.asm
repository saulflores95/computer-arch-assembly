MODEL small
  .STACK 100h

  INCLUDE procs.inc

  LOCALS

  .DATA
    inicio      db  "Copia Memoria",  0
    final       db  "Final de Programa", 0
    new_line    db  13, 10, 0,
    Fuente      db  "Soy GenialAAAAAAAAAAAAAAAAAAAAAAAA", 0
    Destino     db  32 dup(?)

  .CODE

  Principal   PROC
              mov ax, @DATA
              mov ds, ax
              call clrscr

              mov dx, offset inicio
              call puts

              mov dx, offset new_line
              call puts

              mov bx, offset Fuente
              mov dx, offset Destino
              mov cx, 16

              call CopiaMemoria

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
CopiaMemoria  PROC
              mov si, 0
              mov bp, dx
@@loopSi:     mov ax, [bx + si]
              mov [bp + si], ax
              mov ax, [bp + si]
              call putchar
              dec cx
              inc si
              cmp cx, 0
              je @@exitProc
              jmp @@loopSi
@@exitProc:   ret
              ENDP

END
