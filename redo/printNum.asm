MODEL small
  .STACK 100h

  INCLUDE procs.inc

  LOCALS

  .DATA
    inicio    db  "Print Number Base: ",0
    final     db  "Final de conversion",0
    new_line  db  13, 10, 0
  .CODE

Principal     PROC
              mov ax, @DATA
              mov ds, ax
              call clrscr

              mov dx, offset inicio
              call puts


              call newLine
              mov ax, 1Ah
              mov bx, 16
              call printNumBase
              call newLine

              mov dx, offset final
              call puts

              mov ah, 04ch
              mov al,0
              int 21h
              ret
              ENDP
            ;--Procedimientos--

printNumBase  PROC
              mov cx, 0
              mov si, 0
  @@division: div bx
              push dx
              mov dx, 0
              inc si
              cmp ax, 0
              jne @@division

  @@print:    pop dx
              add dx, "0"
              mov ah, 02h
              int 21h
              dec si
              cmp si, 0
              jne @@print
              ret
              ENDP
newLine       PROC
              push dx
              mov dx, offset new_line
              call puts
              pop dx
              ret
              ENDP

END
