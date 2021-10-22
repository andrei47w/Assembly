bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db '+', '4', '2', 'a', '@', '3', '$', '*'
    l equ $-s
    d times l db 0 ;reserve space for d string
    ;d should become: '@','$','*'
    
; our code starts here
segment code use32 class=code
    start:
        ;  Given a character string S, obtain the string D containing all special characters (!@#$%^&*) of the string S. 
    
    mov ecx, l              ;save in ecx s length
    mov esi, 0
    mov ebx, 0
    
    jecxz Sfarsit
    Repeta:                 ;loops l times
        mov al, [s+esi]     ;moves in al the next element from s which will be compared
        cmp al, '!'
        je skip
        cmp al, '@'
        je skip
        cmp al, '#'
        je skip
        cmp al, '$'
        je skip
        cmp al, '%'
        je skip
        cmp al, '^'
        je skip
        cmp al, '&'
        je skip
        cmp al, '*'
        je skip
        jmp notSymbol 
        skip:           ;skips the cases remaining to compare so flags don't change after finding a symbol
            mov [d+ebx], al     ;moves in d the symbol found in s            
            inc ebx     ;prepares for adding the next element in d by increasing ebx
        notSymbol:      ;skips moving the element in d if it's not a symbol
        inc esi         ;increses esi so it can check the next element
    loop Repeta
    Sfarsit:            ;ends loop after all elements have been checked
            
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
