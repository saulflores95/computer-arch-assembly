MODEL small
  .STACK 100h

  INCLUDE procs.inc

  LOCALS

  .DATA
    inicio      db  "Es Polindromo?",  0
    poli        db  "Si lo es", 0
    notPoli     db  "No lo es", 0
    final       db  "Final de Programa", 0
    new_line    db  13, 10, 0,
    cadena      db  "oso",0
  .CODE

  Principal   PROC
              mov ax, @DATA
              mov ds, ax
              call clrscr

              mov dx, offset inicio
              call puts

              mov dx, offset new_line
              call puts

              call polindromo
              cmp ch, 1
              je @@isPoli

              mov dx, offset notPoli
              call puts
              jmp @@notPoliCont

@@isPoli:     mov dx, offset poli
              call puts

@@notPoliCont:mov dx, offset new_line
              call puts

              mov dx, offset final
              call puts

              mov ah, 04ch
              mov al,0
              int 21h
              ret
              ENDP
            ;--Procedimientos--
polindromo    PROC

              mov di, 0
              mov si, 2
              mov ch, 1
@@compare:    cmp si, 0
              je @@exit
              mov dx, offset cadena
              mov bx, dx
              mov al, [bx+di]
              cmp al, [bx+si]
              je @@nextVal
              jmp @@notEqual

@@nextVal:    dec si
              inc di
              jmp @@compare

@@notEqual:   mov ch,0

@@exit:       ret
              ENDP

END
