MODEL small
  .STACK 100h

  INCLUDE procs.inc

  LOCALS

  .DATA
    inicio      db  "Ingrese un valor hexadecimal",  0
    final       db  "Final de Programa", 0
    outrange    db  "Character no es valido",0
    new_line    db  13, 10, 0,

  .CODE

  Principal   PROC
              mov ax, @DATA
              mov ds, ax
              call clrscr

              mov dx, offset inicio
              call puts

              mov dx, offset new_line
              call puts

              call getHexbyte

              mov dx, offset new_line
              call puts

              call putchar

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
  getHexbyte  PROC
              mov si, 0

@@capLoop:    call getchar

              cmp al,13
              je @@exitProc

              cmp al, '0'
              jl @@outoFRange

              cmp al, '9'
              jle @@capture

              cmp al, ':'
              jge @@rangeCheck

@@rangeCheck: cmp al, '@'
              jle @@outoFRange

@@uppercase:  cmp al, 'A'
              jge @@upLimitMax

@@upLimitMax: cmp al, 'F'
              jle @@capture

              cmp al, '['
              jge @@checkLimit

@@checkLimit: cmp al, '`'
              jle @@outoFRange

@@lowercase:  cmp al, 'a'
              jge @@lowercaseLimit

@@lowercaseLimit:
              cmp al, 'f'
              jg @@outoFRange

@@capture:
              cmp al, 57
              jbe @@subNum

              cmp al, 70
              jbe @@subMayu

              cmp al, 102
              jbe @@subMinu

@@shift:      mov cl, 4
              shl al, cl
              mov cl, al
              inc si
              jmp @@comp

@@subNum:     sub al, 48
              cmp si, 1
              je @@cont
              jmp @@shift

@@subMayu:    sub al, 55
              cmp si, 1
              je @@cont
              jmp @@shift

@@subMinu:    sub al,87
              cmp si, 1
              je @@cont
              jmp @@shift


@@cont:       add al, cl
              inc si

@@comp:       cmp si, 2
              je @@exitProc
              jmp @@capLoop

@@outoFRange:
              mov dx, offset new_line
              call puts
              mov dx, offset outrange
              call puts
              mov dx, offset new_line
              call puts
              jmp @@capLoop

@@exitProc:   mov byte ptr [bx+si],0
              ret
              ENDP

END
