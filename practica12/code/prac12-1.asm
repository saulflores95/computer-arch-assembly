MODEL small
  .STACK 100h

  INCLUDE procs.inc

  LOCALS

  .DATA
    mens_directo db  "Desplegado de caraccter en forma directa:  ",0 ;Se imprime al inicio del programa
    mens_DOS     db  "Desplegado de caracter usando DOS: ",0
    mens_BIOS    db  "Desplegado de caracter usando BIOS: ",0 ;Variable con valor a imprimir debugFunc
    new_line     db  13, 10, 0 ;imprime una linea nueva
  .CODE

Principal     PROC
              mov ax, @DATA
              mov ds, ax
              call clrscr

              mov dx, offset mens_directo
              call puts
              mov al, 'X'   ; caracter a deplegar
              mov bh, 41
              mov bl, 0     ; posicion (41,0)
              call putcharxy; imprime caracter (DL) en posicion (x,y)

              call newLine

              mov dx, offset mens_DOS
              call puts
              mov dl, 'X' ; caracter a desplegar
              mov ah, 2   ; servicio: desplegar caracter
              int 21h     ;imprimir caracter que esta en DL

              call newLine

              mov dx, offset mens_BIOS
              call puts

              mov al, 'X'
              mov ah, 0Ah
              mov bx,0
              mov cx, 1
              int 10h

              call newLine

              mov ah, 04ch
              mov al,0
              int 21h
              ret
              ENDP

;--Procedimientos--
putcharxy     PROC
              push ax ; salvar valores de registros a utilizar
              push bx
              push cx
              push dx
              push ds

              mov dx, ax      ; DL memoria de video

              mov ax, 0b800h  ; hacer que DS apunte al segmento
              mov ds, ax      ; de memoria de video

              mov cl, 160   ; calcular localidad de memoria segun
              mov al, bl    ;posicion(x,y)
              mul cl        ; X: esta en BH y Y: en BL
              mov bl, bh    ; localidad en memoria = (x*2) + (y*160)
              mov bh, 0
              shl bx, 1     ; Se require BX=(BL*160) + (BH*2)
              add bx, ax

              mov [bx],dl   ;mover DL a la localidad DS:BX

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
