bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    
    a dw 2
    b dw 10
    c dw 23
    d dw 3
    
; our code starts here
segment code use32 class=code
    start:
        
    ;(c+b)-a-(d+d) 
    
    mov eax, 0
    mov ebx, 0
    
    mov ax, [c]
    add ax, [b]
    
    mov bx, [d]
    add bx, [d]
    
    sub ax, [a]
    sub ax, bx
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
