;**********************************************************************
; Rutina: gets
; Descripcion: Caputura cadena, inicio de memoria se indica con el registro(DX)
;              Nota: La caputra continuara hasta que el usuario presione enter o se llene la memoria
; Parametros:
;    DX:  offset variable
;    Salida:   cuando AL tenga el valor de 13 (Enter)
;**********************************************************************
   extrn gets:near
