bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data

        ;a,b,c-byte; d-doubleword; e-qword    
    a db 4
    b db 34
    c db 8
    d dd 140
    e dq 280

; our code starts here
segment code use32 class=code
    start:
    
        ; 2/(a+b*c-9)+e-d; 
        
    mov eax, 0
    
    mov al, [b]
    mul byte [c]    ; ax = b*c
    
    add ax, [a]
    sub ax, 9       ; ax = a+b*c-9
    
    mov bx, ax
    mov ax, 2
    mov dx, 0       ; dx:ax = 2
    
    div bx         ; ax = 2/(a+b*c-9)
    
    mov edx, 0     ; edx:eax = 2/(a+b*c-9)
    
    add eax, dword [e]
    adc edx, dword [e+4]    ; edx:eax = 2/(a+b*c-9)+e
    
    mov ebx, eax
    mov ecx, edx            ; ecx:ebx = 2/(a+b*c-9)+e
    
    mov eax, [d]
    mov edx, 0              ; edx:eax = d
    
    sub ebx, eax
    sbb ecx, edx            ; ecx:ebx = 2/(a+b*c-9)+e-d;
    
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
