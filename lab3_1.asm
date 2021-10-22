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
    b dw 54
    c dd 152
    d dq 300

; our code starts here
segment code use32 class=code
    start:
        ; c-(a+d)+(b+d) = 204
        
        mov eax, 0
        mov edx, 0
        
        mov al, [a]     ; al = a
        cbw             ; ax = a
        cwde            ; eax = a
        cdq             ; edx:eax = a
        
        add eax, dword [d]      
        adc edx, dword [d+4]    ; edx:eax = a+d
        
        mov ebx, eax
        mov ecx, edx    ; ecx:ebx = a+d
        
        mov ax, [b]
        cwde
        cdq             ; edx:eax = b
        add eax, dword [d]
        adc edx, dword [d+4]    ; edx:eax = d+b
        
        sub eax, ebx
        sbb edx, ecx            ; edx:eax = -(a+d)+(b+d)
        
        mov ebx, eax
        mov ecx, edx            ; ecx:ebx = -(a+d)+(b+d)
        
        mov eax, [c]
        cdq                     ; edx:eax = c
        
        add eax, ebx
        adc edx, ecx            ; edx:eax = c-(a+d)+(b+d)
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
