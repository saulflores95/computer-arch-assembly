  INCLUDE procs.inc

  _TEXT segment byte public 'CODE'
    assume cs:_TEXT
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
  _TEXT       ends
              PUBLIC gets
  END
