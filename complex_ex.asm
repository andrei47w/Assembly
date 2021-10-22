Nbits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 10
    d dw 40
    ;; c dd 12
    

; our code starts here
segment code use32 class=code
    start:
        
        mov  AX, [b] ;AX = b
	div  BYTE [a] ;AL = AX / a = b / a și AH = AX % a = b % a
	
	mov  AH, 2 ;AH = 2
	mul  AH ;AX = AL * AH = b / a * 2	
	
	add  AX, 10 ;AX = AX + b = b / a * 2 + 10
	
	mul  word [b] ;DX:AX = AX * b = (b / a * 2 + 10) * b
	
	push  DX ;se pune pe stiva partea high din double word-ul DX:AX
	push  AX ;se pune pe stiva partea low din double word-ul DX:AX
	pop  EBX ;EBX = DX:AX = (b / a * 2 + 10) * b
	
	mov  AX, [b] ;AX = b
	mov  DX, 15 ;DX = 15
	mul  DX ;DX:AX = b * 15
	
	push  DX ;se pune pe stiva partea high din double word-ul DX:AX
	push  AX ;se pune pe stiva partea low din double word-ul DX:AX
	pop  EAX ;EAX = DX:AX = b * 15
	
	sub  EBX, EAX ;EBX = EBX - EAX = (b / a * 2 + 10) * b - b * 15
	
	push   dword 0 ;se pune pe stiva codul de retur al functiei exit
	call   [exit] ;apelul functiei sistem exit pentru terminarea executiei programului
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program