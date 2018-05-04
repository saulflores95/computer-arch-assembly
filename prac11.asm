MODEL small
  .STACK 100h

  INCLUDE procs.inc

  LOCALS

  .DATA
    inicio    db  "Convirtiendo string a entero ",0 ;Se imprime al inicio del programa
    final     db  "Final de conversion",0 ; Se imprime al final del programa
    dgb       db  "debug -->",0 ;Variable con valor a imprimir debugFunc
    new_line  db  13, 10, 0 ;imprime una linea nueva
    cadena    db  "1238", 0 ;Se define a cadena
    tamano    dw  3  ;Se define el tamano de arreglo de cadena
    base      dw  16 ;Se define la base a convertir
  .CODE

Principal     PROC
              mov ax, @DATA
              mov ds, ax
              call clrscr
              ;Impresion de variable inicio
              mov dx, offset inicio
              call puts
              ;Linea nueva
              call newLine
              ;se ingresa valor de cadena a bx
              mov bx, offset cadena
              call strDec2num ;se ejecuta strDec2num y retorna el valor en ax

              mov bx, base  ;se asigna base a bx
              call printNumBase ;se llama funcion printNumBase

              call newLine

              mov dx, offset final
              call puts

              mov ah, 04ch
              mov al,0
              int 21h
              ret
              ENDP
            ;--Procedimientos--

strDec2num    PROC
              mov si, tamano ;tamano de arreglo
              mov di, 0 ;contador de iteraciones
              mov cl, 4 ;cantidad de 0 para shift
              ;primer caracter capturado
              mov ax, [bx] ;se almacena el valor de bx
              sub ax, 30h
              mov ah, 0 ;limpiamos el contenid de ah, esto evita un error en los valors mayores a 1
              cmp si, 0 ;si el valor de si es igual a 0
              je @@exit ;saltamos al final
              ;arreglo caracteres es mayor a uno
    @@incLoop:inc di ;i++
              shl ax, cl ;recorremos ax un nibble
              mov dx, ax ; almacenamos ax en bx
              mov ax, 0  ;limpanos ax
              mov al, [bx+di] ;obetenemos siguiente caracter
              sub al, 30h
              add ax, dx ; se le suma dx (ax viejito) a ax
              mov dx, 0 ; se vacia contenido en dx
              cmp di, si  ;se compara si el contador de iteracion y tamano arreglo de caracteres es igual
              jne @@incLoop

  @@exit:     ret
              ENDP

printNumBase  PROC
              mov cx, 0
              mov si, 0
  @@division: div bx  ;se traba aqui
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

debugFunc     PROC
              push dx
              mov dx, offset dgb
              call puts
              call newLine
              pop dx
              ret
              ENDP

END
