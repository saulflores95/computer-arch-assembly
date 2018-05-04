;getch - sin eco en pantalla
;getchar - con eco en pantalla
;Ambas get y getchar retornan en AL el caracter ingresado
;--Procedimientos en PCLIB06
;----getch: Almacena en AL el caracter ingresado por el usuario.
;---------- No se deplega en pantalla
;----getchar: Similar al anterior pero si se depliega el caracter
;------------ en pantalla
;----puts: Despliga en pantalla una cadena direcciona por DX. la cadena debe
;------------estar terminada en 0
;-----gotoxy: Posiciona el cursos en las cordenadas indicadas por BH y BL
;------------ BH: posicion x
;-------------BL: posicion y
MODEL small
  .STACK 100h

  INCLUDE procs.inc

  LOCALS

  .DATA
    inicio      db  "Ingrese una cadena:        ",0
    final       db  "Final de Programa         ",0
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
            call gets

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
  gets  PROC
            mov bx, dx
            mov si, 0
 @@capLoop: call getchar
            cmp al,13
            je @@exitProc
            mov [bx+si], al
            inc si
            jmp @@capLoop
@@exitProc: mov byte ptr [bx+si],0
            ret
            ENDP
  END
