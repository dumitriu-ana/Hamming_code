; Proiect -  Ana 
; Cerinta: Se citeste un sir de 4 biti. Sa se afiseze codul Hamming corespunzator. 
; Se citest doar valori de 0 si 1, se afiseaza 7 biti

.model small         ; model de memorie 
.stack 100h          ; definesc stiva de 256oct
.data                ; segment de date
mesaj0 db 13,10,'Se va citi o insiruire de patru biti, 0 si 1.','$'
mesaj1 db 13,10,'bit 1=','$'     ; 13, 10= linie noua 
mesaj2 db 13,10,'bit 2=','$' 
mesaj3 db 13,10,'bit 3=','$' 
mesaj4 db 13,10,'bit 4=','$' 
rezultat db 13,10,'Codul Hamming: ','$' 
restul db 13,10,'puteri=','$'
nr1 db ?             
nr2 db ?            ; aloc zona de memorie si dau val 0 ?
nr3 db ? 
nr4 db ?
p1 db ?
p2 db ?
p3 db ?
r db ?
s db ?    
          
.code               ;segment de cod

; PROCEDURI
spatiu proc
	mov dl, 20h     ; spatiu 
	mov ah, 2       ; afisez ce e in dl, spatiu, 2 este intreruperea de afisare
	int 21h
	ret             ; redau controlul programului principal
spatiu endp         ; inchid procedura

citire proc
	mov ah, 01h     ; 01h este comanda de citire
	int 21h 
	ret
citire endp

imp proc
	mov bl, 2       ; in bl se pune impartitorul
	div bl          ; impart la impartitor, la 2
	ret
imp endp

; PROGRAM PRINCIPAL
start: 
	mov ax,@data     
	mov ds,ax        ; setez registrul ds sa faca referire la segm de date

	mov ah,09h       ; afisez mesaj
	mov dx,offset mesaj0   ; mut adresa de la mesaj 0 in dx
	int 21h 

	mov ah,09h       ; afisez mesaj
	mov dx,offset mesaj1    ;adresa e pe 2oct
	int 21h 

	call citire      ; citesc nr 1, numarul citit se duce in al
	mov nr1, al      ; pun numarul citit in variabila

	mov ah,09h       ; afisez mesaj
	mov dx,offset mesaj2
	int 21h 

	call citire   
	mov nr2, al      ; mut in nr2

	mov ah,09h       ; afisez mesaj
	mov dx,offset mesaj3
	int 21h 
	
	call citire  
	mov nr3, al      ; mut in nr3

	mov ah,09h       ; afisez mesaj
	mov dx,offset mesaj4
	int 21h 
	
	call citire  
	mov nr4, al      ; mut in nr4

; PUTEREA p1
	mov al, nr1      ; fac suma  dintre nr1, nr2 si nr4
	add al, nr2
	add al, nr4

	mov s, al        ; mut suma din al in variabila s

	mov ah, 0h       ; descompun s in 2 parti: in ah pun 0, in al pun s, deci in ax va fi s
	mov al, s

	call imp         ; apelez procedura care imparte la 2 continutul lui ax, catul se duce in al, restul se duce in ah
	mov p1, ah       ; pun restul in p1

; PUTEREA p2
	mov al, nr1      ; pentru puterea a p2, adun nr1, nr3 si nr 4 si calculez restul impartirii sumei la 2
	add al, nr3
	add al, nr4

	mov s, al

	mov ah, 0h       ; descompun s in 2 parti
	mov al, s

	call imp
	mov p2, ah       ; pun restul in p2

; PUTEREA p3
	mov al, nr2      ; pentru puterea a p2, adun nr2, nr3 si nr4 si calculez restul impartirii sumei la 2  
	add al, nr3
	add al, nr4

	mov s, al

	mov ah, 0h       ; descompun s in 2 parti
	mov al, s

	call imp         ; apelez procedura de impartire
	mov p3, ah       ; pun restul in p3
 
; AFISARE
	mov ah,09h       ; afisez mesaj
	mov dx,offset rezultat
	int 21h 

	mov dl, p1      ; pun p in dl
	add dl, 30h     ; transform in caracter
	mov ah, 2       ; afisez ce e in dl, adica p1
	int 21h

	call spatiu     ;afisez spatiu

	mov dl, p2      ; pun p2 in dl
	add dl, 30h     ; transform in caracter
	mov ah, 2       ; afisez
	int 21h

	call spatiu     ; afisez spatiu

	mov dl, nr1     
	mov ah, 2       ; afisez ce e in dl
	int 21h

	call spatiu     ; afisez spatiu

	mov dl, p3      ; mut p3 in dl
	add dl, 30h
	mov ah, 2       ; afisez ce e in dl
	int 21h

	call spatiu

	mov dl, nr2 
	mov ah, 2 
	int 21h

	call spatiu

	mov dl, nr3
	mov ah, 2 
	int 21h

	call spatiu

	mov dl, nr4
	mov ah, 2 
	int 21h

	mov ah,4Ch     ; codul de terminare 
	int 21h 
end start
