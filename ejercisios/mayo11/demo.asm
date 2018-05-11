;------------------------------------------------------------------------------
; Cree la libreria user.lib la cual contendra el procedimiento gets
; 1. Archivo gets.asm
; INCLUDE procs.inc ← si utlizan Procedimientos de pclib06
; _TEXT segment byte public 'CODE'
;     assume cs:_TEXT
;     gets PROC
;       Codigo Aqui
;     ENDP
; _TEXT ends
;       public gets
; END
; 2. Ensamble gets.asm
; 3. Cree user.lib: ← Descargue Tlib.exe de moodle
;     Tlib user.lib tgets.obj /c
; 4.Cree user.inc (basese en el archivo procs.in)
; 5. Inlcluya la libreria en formato.asm y ejemplifique el uso del procedimiento gets
; 6. Ensamble formato.asm, encadena de la forma
;       tlink formato.obj,,,pclib06 user.lib
; 7.Ejecute formato.exe
;-------------------------------------------------------------------------------

MODEL small
  .STACK 100h

  INCLUDE procs.inc
  INCLUDE user.inc

  LOCALS

  .DATA
    inicio    db  "Inicio del programa: ",0
    final     db  "Final de conversion",0
    cadena    db  32 dup(?),
    new_line  db  13, 10, 0
  .CODE

Principal     PROC
              mov ax, @DATA
              mov ds, ax
              call clrscr

              mov dx, offset inicio
              call puts

              mov dx, offset cadena
              call gets
              mov dx, offset cadena
              call puts

              call newLine

              mov dx, offset final
              call puts

              mov ah, 04ch
              mov al,0
              int 21h
              ret
              ENDP
            ;--Procedimientos--
newLine       PROC
              push dx
              mov dx, offset new_line
              call puts
              pop dx
              ret
              ENDP

END
