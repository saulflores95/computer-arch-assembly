# Interrupciones
### Hay dos tipos:

 1. Interrupcion por software.
 2. Interrupcion por hardware (Asyncrono no sabes cuando se va a ejecutar).

Cada interrupcion tiene un peso de 4 bytes.
|Vectores de INT| |
|--|--|
|IP LOW|0000  |
| IP HIGH |0001|
| CS LOW |0002|
|CS HIGH |0003|

### Metodologia cuando occurre una inerrupcion:

 - Push banderas. (Salvo las banderas)
 - Desactivar trace mode y las interrupciones. (Desactivo paso sencillo y no quiero que las int interrupan la int que se esta ejecutand).
 - Push CS (Se obtiene del vector de interrupciones se obtiene la direccion donde se va a sobrecribir multiplicando por 4).
 - Asignar valor a cs
 - Push IP
 - Asignar valor a IP
 - Ejecutar ISR

**Que hace Ret y IRET ?**

 - Pop IP
 - pop CS
 - pop Banderas (Solamente IRET hace esta)

**Activar o desactivar interrupcion**

 - CLI:	Desactiva interrupciones
 - STI:  Activar int
