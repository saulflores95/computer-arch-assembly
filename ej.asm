printNumBase2 PROC
              push ax
              push bx
              push cx
              push dx
              mov dx,0
              mov bx,0
              mov cx,16
      @@loop1:cmp ax,0
              je @@loop2
              div cx
              push dx
              mov dx,0
              inc bl
              jmp @@loop1

      @@loop2:cmp bl,0
              je @@loop3

              pop ax
              cmp ax,10
              jl @@suma1
              add ax,7

      @@suma1:add ax,48
              call putchar
              dec bl
              jmp @@loop2

      @@loop3:mov al,10
              call putchar
              mov al,13
              call putchar

              pop dx
              pop cx
              pop bx
              pop ax

              ret
              ENDP
