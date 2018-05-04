MODEL small ;--Specifies the memori model that is going to be used by our program

  .STACK 100h ;--The default start for our machine code

INCLUDE procs.inc

LOCALS

.DATA ;store all variables that we need in the program
  inicio db 'while loop activated$'
  loopEnd db ' while loop finished$'
  index db 5

.CODE ;--Insert program, subrutine call, etc., here
  start:
    mov ax, @data
    mov ds, ax
    mov cl, index

    mov dx, offset inicio
    jmp print
    ;While cl does not equal two do
    while: cmp cl,2
    je finished
    ;print the current index
    jmp printWithSpace
    returnToLoop : mov dl,cl
    add dl,30h
    mov ah,02h
    int 21h
    ;decrement cl
    dec cl
    ;loop
    jmp while

    printWithSpace: mov dl,20h
    mov ah,02h
    int 21h
    jmp returnToLoop

    finished:  mov dx, offset loopEnd
    print: mov ah, 09h
    int 21h ;--tells the processor to stop whatever its doing and execute the commands above it
    ;if cl does not equal 2 return to while lopp
    cmp cl,2
    jne while
    ;exit the program
    mov ah, 4ch
    int 21h
  end start
