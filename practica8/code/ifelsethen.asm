MODEL small ;--Specifies the memori model that is going to be used by our program

  .STACK 100h ;--The default start for our machine code

INCLUDE procs.inc ;-inluced procs.inc library

LOCALS ;--not sure what this does :p

.DATA ;store all variables that we need in the program
  varOne db 110
  varTwo db 15
  ifGreaterText db "BL reg is bigger or equal$"
  elseSmallerText db "CL reg is bigger$"
.CODE ;--Insert program, subrutine call, etc., here
  start:
    mov ax, @data
    mov ds, ax

    mov bl, varOne
    mov cl, varTwo

    cmp bl, cl
    jg ifGreater
    jl ifSmaller
    ifGreater :  mov dx, offset ifGreaterText
    jmp impresion
    ifSmaller : mov dx, offset elseSmallerText
    impresion : mov ah, 09h
    int 21h
    ;--exit the program
    mov ah, 4ch
    int 21h
  end start
