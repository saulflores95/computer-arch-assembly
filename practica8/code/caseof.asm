MODEL small ;--Specifies the memori model that is going to be used by our program

  .STACK 100h ;--The default start for our machine code

INCLUDE procs.inc

LOCALS

.DATA ;store all variables that we need in the program
  case0 db 'case 0 activated$'
  case1 db 'case 1 activated$'
  case2 db 'case 2 activated$'
  case3 db 'case 3 activated$'
  caseVal db 1

.CODE ;--Insert program, subrutine call, etc., here
  start:
    mov ax, @data
    mov ds, ax
    mov bl, caseVal

    cmp bl,0
    je isCero
    cmp bl,1
    je isOne
    cmp bl,2
    je isTwo
    cmp bl,3
    je isThree

    isCero: mov dx, offset case0
    jmp print
    isOne: mov dx, offset case1
    jmp print
    isTwo: mov dx, offset case2
    jmp print
    isThree: mov dx, offset case3
    jmp print

    print : mov ah, 09h
    int 21h ;--tells the processor to stop whatever its doing and execute the commands above it
    mov ah, 4ch ;exit the program
    int 21h
  end start
