bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 1111111111111111b
    b dw 1111111111111111b
    c dd 0

; our code starts here
segment code use32 class=code
    start:
        ;    Given the words A and B, compute the doubleword C as follows:
        ;the bits 0-3 of C are the same as the bits 5-8 of B
        ;the bits 4-8 of C are the same as the bits 0-4 of A
        ;the bits 9-15 of C are the same as the bits 6-12 of A
        ;the bits 16-31 of C are the same as the bits of B

    mov eax, 0
    
    mov bx, [b]
    and bx, 111100000b ;isolate bits 5-8 of b
    mov cl, 5
    ror bx, cl  ;move to the right by 5 positions
    or ax, bx   ;move the bits to positions 0-3 in c
    
    mov bx, [a]
    and bx, 11111b  ;isolate bits 0-4 of a
    mov cl, 4
    rol bx, cl  ;move to the left by 4 positions
    or ax, bx   ;move the bits to postions 4-8 in c
    
    mov bx, [a]
    and bx, 1111111000000b  ;isolate bits 6-12 of a
    mov cl, 3
    rol bx, cl  ;move to the left by 3 positions
    or ax, bx   ;move the bits to positions 9-15 in c
    
    mov ebx, 0
    mov bx, [b] ;move b to ebx
    mov cl, 16  
    rol ebx, cl ;move to the left by 16 positions
    or eax, ebx ; move the bits to positions 16-31 in c
    
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
