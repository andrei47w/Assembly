bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    
    a db 2
    b db 2
    c db 6
    d dw 12
    
; our code starts here
segment code use32 class=code
    start:
    
    ; d*(d+2*a)/(b*c) 
    
    mov eax, 0
    mov ebx, 0
    
    mov al, 2
    mul byte [a]
    add ax, [d]
    
    mul word [d]
    
    mov ebx, eax
    mov al, [b]
    mul byte [c]
    
    mov al, cl
    mov eax, ebx
    div cl
    
    
    
        
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
