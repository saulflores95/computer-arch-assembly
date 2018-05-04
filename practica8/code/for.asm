MODEL small ;--Specifies the memori model that is going to be used by our program

  .STACK 100h ;--The default start for our machine code

INCLUDE procs.inc

LOCALS

.DATA ;store all variables that we need in the program
  inicio db 'for loop activated$'
  loopEnd db ' for loop finished$'
  index db 0
.CODE ;--Insert program, subrutine call, etc., here
  start:
    mov ax, @data
    mov ds, ax
    mov cl, index
    mov dx, offset inicio
    jmp print

    goBack : cmp cl,5
    je finished

    jmp printWithSpace
    returnToLoop : mov dl,cl
    add dl,30h
    mov ah,02h
    int 21h
    inc cl
    jmp goBack

    printWithSpace : mov dl,20h
    mov ah,02h
    int 21h
    jmp returnToLoop

    finished:  mov dx, offset loopEnd
    print: mov ah, 09h
    int 21h ;--tells the processor to stop whatever its doing and execute the commands above it
    ;If cl does not euql 0 reuturn to for loop
    cmp cl,5
    jne goBack
    ;exit the program
    mov ah, 4ch
    int 21h
  end start
