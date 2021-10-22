bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf              
import exit msvcrt.dll    
import printf msvcrt.dll  
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    
    
    a dd 0
    b dd 0
    rezultat dd 0
    message1 db "a = ", 0
    message2 db "b = ", 0
    format1 db "%d", 0
    format2 db "a/b = %d", 0

; our code starts here
segment code use32 class=code
    start:
        ; Sa se citeasca de la tastatura doua numere a si b (in baza 10) si sa se calculeze a/b. Catul impartirii se va salva in memorie in variabila "rezultat" (definita in segmentul de date). Valorile se considera cu semn. 
        
        push dword message1      ;prints: "a = "
        call [printf]
        add esp, 4*1
            
            push dword a             ;reads: a
        push dword format1
        call [scanf]
        add esp, 4*2    
        
        push dword message2      ;prints: "b = "
        call [printf]
        add esp, 4*1
        
        push dword b             ;reads b
        push dword format1
        call [scanf]
        add esp, 4*2

        mov eax, 0               ;computes a/b
        mov eax, [a]
        cdq
        idiv dword[b]
        mov dword[rezultat], eax ;stores the result in rezultat
    
        push dword [rezultat]    ;prints "a/b = [rezultat]"
        push dword format2
        call [printf]
        add esp, 4*2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
