MODEL small
  .STACK 100h

  INCLUDE procs.inc

  LOCALS

  .DATA
    mens_so      db "Desplegado de cadena en forma directa:  ",0 ;Se imprime al inicio del programa
    mens_putsxy  db "Desplegado de caracter usando putsxy: ",0
    mens_BIOS    db "Desplegado de caracter usando BIOS: ",0 ;Variable con valor a imprimir debugFunc
    cadena       db "Soy una cadena feliz$"
    cadenaTwo    db "Soy una cadena con cero",0
    final        db "Fin del programa",0
    new_line     db  13, 10, 0 ;imprime una linea nueva
  .CODE

Principal     PROC
              mov ax, @DATA
              mov ds, ax
              call clrscr

              mov dx, offset mens_so
              call puts
              mov ah, 09
              mov dx, offset cadena
              int 21h
              call newLine

              mov dx, offset mens_BIOS
              call puts
              mov al, 1
              mov bh, 0
              mov bl, 00111011b
              mov cx, msg1end - offset msg1 ; calculate message size.
              mov dl, 35
              mov dh, 1
              push cs
              pop es
              mov bp, offset msg1
              mov ah, 13h
              int 10h
              jmp msg1end
              msg1 db " hello, world! "
              msg1end:
              call newLine

              mov dx, offset mens_putsxy
              call puts
              mov dh, 10
              mov dl, 10    ; posicion (41,0)
              call putxy; imprime caracter (DL) en posicion (x,y)



              mov dx, offset final
              call puts

       @@exit:mov ah, 04ch
              mov al,0
              int 21h
              ret
              ENDP

;--Procedimientos--
putxy     PROC
              push ax ; salvar valores de registros a utilizar
              push bx
              push cx
              push dx
              push ds

              mov ah, 02h
              int 10h

              mov dx, offset cadenaTwo      ; DL memoria de video
              call puts

              pop ds        ;recuperar valores originals de registros
              pop dx        ; utilizados
              pop cx
              pop ax
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
