MODEL small ;--Specifies the memori model that is going to be used by our program

  .STACK 100h ;--The default start for our machine code

INCLUDE procs.inc

LOCALS

.DATA ;store all variables that we need in the program
  startProgram db ' do while initialized $'
  doSegment db ' Inside loop $'
  finishedProgram db ' do while exited $'
  index db 5
.CODE ;--Insert program, subrutine call, etc., here
  start:
    mov ax, @data
    mov ds, ax
    mov cl, index

    mov dx, offset startProgram
    jmp print

    startLoop: mov dl, cl
    add dl,30h
    mov ah,02h
    int 21h
    dec cl
    cmp cl,2
    je exit
    jmp startLoop

    print: mov ah,09h
    int 21h
    jmp startLoop

    exit:  mov dx, offset finishedProgram
    mov ah, 09h
    int 21h
    mov ah, 4ch ;exit the program
    int 21h
  end start
