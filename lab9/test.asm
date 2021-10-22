bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

extern exit, fopen, fprintf, fclose, scanf, printf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fprintf msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32
	format1 db "Give string = ", 0
    format2 db "%x", 0
    format3 db "%s", 0
    ;617269614D
    char_string times 100 db 0
    string times 100 db 0

segment code use32 class=code
start:    

    push dword format1
    call [printf]
    add esp, 4*1
    
	push dword char_string             
    push dword format3
    call [scanf]
    add esp, 4*2 
    
    sub byte [char_string], 48
    mov al, [char_string]
    mov [string], al
    
    sub byte [char_string + 1], 48
    mov al, [char_string + 1]
    mov [string+1], al
    
    mov cl, 4
    rol byte[string], cl
    rol byte[string + 1], cl
    
    mov bl, [string+1]
    and bl, 1111b
    
    add byte[string], bl
    
    push dword char_string
    push dword format3
    call [printf]
    add esp, 4*2
    

        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
