bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s dw 1432h, 8675h, 0ADBCh
    l equ ($-s)/2
    d times l dd 0
    ; d should become 01020304h, 05060708h, 0A0B0C0Dh
    rezultat dd 01020304h, 05060708h, 0A0B0C0Dh
    cifra1 db 0
    cifra2 db 0
    cifra3 db 0
    cifra4 db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; An array of words is given. Write an asm program in order to obtain an array of doublewords, where each doubleword will contain each nibble unpacked on a byte (each nibble will be preceded by a 0 digit), arranged in an ascending order within the doubleword. 
    
    mov ecx, 0
    mov ecx, l      ; puts s length in ecx
    mov esi, 0
    mov edi, 0      
    
    parcurgeSirul:
        mov eax, 0
        mov byte[cifra1], 0
        mov byte[cifra2], 0
        mov byte[cifra3], 0
        mov byte[cifra4], 0     ; clears the memory which will be used for sorting
        mov ax, [s+esi]         ; puts in ax, ecx th element from the string
        
        mov [cifra1], al
        and byte[cifra1], 1111b ; stores the 0-3 bits from ax
        
        mov [cifra2], al
        and byte[cifra2], 11110000b
        ror byte[cifra2], 4     ; stores the 4-7 bits from ax
        
        mov [cifra3], ah
        and byte[cifra3], 1111b ; stores the 8-12 bits from ax
        
        mov [cifra4], ah
        and byte[cifra4], 11110000b
        ror byte[cifra4], 4     ; stores the 13-16 bits from ax
        
        
        mov al, [cifra3]
        mov ah, [cifra4]        ; prepares cifra3 and cifra4 for comparison
        cmp al, ah              
        jbe if3above4
            mov [cifra3], ah
            mov [cifra4], al    ; switches ah with al if cifra3 > cifra4
        if3above4:
        
        mov al, [cifra1]
        mov ah, [cifra3]        ; prepares cifra1 and cifra3 for comparison
        cmp al, ah
        jbe if1above3
            mov [cifra1], ah
            mov [cifra3], al    ; switches ah with al if cifra1 > cifra3
        if1above3:
        
        mov al, [cifra2]
        mov ah, [cifra4]        ; prepares cifra2 and cifra4 for comparison
        cmp al, ah
        jbe if2above4
            mov [cifra2], ah
            mov [cifra4], al    ; switches ah with al if cifra2 > cifra4
        if2above4:
        
        mov al, [cifra2]
        mov ah, [cifra3]        ; prepares cifra2 and cifra3 for comparison
        cmp al, ah
        jbe if2above3
            mov [cifra2], ah
            mov [cifra3], al    ; switches ah with al if cifra2 > cifra3
        if2above3:
        
        mov al, [cifra4]
        mov [d+edi], al
        inc edi
        mov al, [cifra3]
        mov [d+edi], al
        inc edi
        mov al, [cifra2]
        mov [d+edi], al
        inc edi
        mov al, [cifra1]
        mov [d+edi], al         
        inc edi                 ; stores the sorted numbers in the new string
        
        inc esi
        inc esi                 ; goes to the next element in s
        dec ecx
    jnz parcurgeSirul           ; jumps if s was not fully parsed
    
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        