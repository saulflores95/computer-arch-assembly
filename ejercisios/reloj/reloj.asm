MODEL small
  .STACK 100h

  INCLUDE procs.inc

  LOCALS

  .DATA
    inicio    db  "Reloj Super Avanzado y Moderno X 2000 ",0 ;Se imprime al inicio del programa
    final     db  "Final del programa",0
    dgb       db  "debug -->",0 ;Variable con valor a imprimir debugFunc
    new_line  db  13, 10, 0 ;imprime una linea nueva
    space     db  32,0
    second    db  8, 0
    second2   db  8, 8, 0
    minutes   db  8,8,8,8,8,0
    minutes2  db  8,8,8,8,8,8,0
    hour      db  8,8,8,8,8,8,8,8,8,0
    hour2     db  8,8,8,8,8,8,8,8,8,8,0
    puntos    db  ":", 32, 0
  .CODE

Principal     PROC
              mov ax, @DATA
              mov ds, ax
              call clrscr
              mov dx, offset inicio
              call puts
              call newLine

              push ds
              mov ax, 0
              mov ds, ax

              mov al, 4
              mov bl, 1ch
              mul bl

              mov bx, ax
              mov word ptr[bx], offset clock

              mov cx, cs
              mov [bx+2], cx

              mov cx, 0
              pop ds
              mov dx, offset space
              call puts

              mov dx, 0
              mov si, 0
              mov di, 0

              mov ax, di
              call printNumBase
              call printNumBase
              mov dx, offset puntos
              call puts

              mov ax, si
              call printNumBase
              call printNumBase
              mov dx, offset puntos
              call puts

              mov ax, 0
              call printNumBase
              call printNumBase

@@updateCount:cmp ch, 1
              je @@incSec
    @@retLoop:jmp @@updateCount

    @@incSec: inc ax
              mov dx, offset second
              cmp ax, 9
              jle @@lesThanNine
              mov dx, offset second2
@@lesThanNine:call puts
              call printNumBase
              mov cx, 0
              cmp al, 59
              jne @@retLoop

    @@incMin: inc si
              mov ax, si
              mov dx, offset minutes
              cmp ax, 9
              jle @@leThNin2
              mov dx, offset minutes2
  @@leThNin2: call puts
              call printNumBase
              mov dx, offset puntos
              call puts
              mov dx, offset space
              call puts
              call puts
              mov ax, 0
              cmp si, 59
              jne @@retLoop

  @@incHour: inc di
              mov ax, di
              mov dx, offset hour
              cmp ax, 9
              jle @@leThNin3
              mov dx, offset hour2
  @@leThNin3: call puts
              call printNumBase
              mov dx, offset puntos
              call puts
              mov dx, offset space
              call puts
              call puts
              call puts
              call puts
              call puts
              mov ax, 0
              mov si, 0
              cmp di, 23
              jne @@retLoop

    @@stop:   call newLine
              mov dx, offset final
              call puts
              mov ah, 04ch
              mov al,0
              int 21h
              ret
              ENDP

;--Procedimientos--
clock         PROC
              inc cl
              ;call debugFunc
              cmp cl, 18
              jne @@outL
              mov ch, 1
      @@outL: iret
              ENDP
;Impresion de valor de un registro con base deseada
printNumBase  PROC
              push ax
              push bx
              push cx
              push dx
              push si

              mov dx,0
              mov bx,10
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

              pop si
              pop dx
              pop cx
              pop bx
              pop ax
              ret
              ENDP
;funcion que imprime un valor de debug
debugFunc     PROC
              push dx
              mov dx, offset dgb
              call puts
              call newLine
              pop dx
              ret
              ENDP
;funcion que imrpime una nueva linea
newLine       PROC
              push dx
              mov dx, offset new_line
              call puts
              pop dx
              ret
              ENDP
END
