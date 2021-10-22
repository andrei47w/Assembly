bits 32
global start

extern exit, printf, scanf              
import exit msvcrt.dll    
import printf msvcrt.dll  
import scanf msvcrt.dll

extern negate_al

segment data use32
	format1 db "Give string = ", 0
    format2 db "%s", 0
    format3 db "%d     ", 0
    char_string times 100 db 0
    example db 44h
    nr_string times 100 db 0
    mult db 0
    cif db 0
    is_neg db 0
    
    negation db -1

segment code use32 class=code
start:    
    push dword format1
    call [printf]
    add esp, 4*1
    
	push dword char_string             
    push dword format2
    call [scanf]
    add esp, 4*2 
    
    mov ecx, 0
    mov ebx, 0
    mov edi, nr_string
    mov esi, char_string
    split_str:
        lodsb
        cmp al, ","
        je skip_all
        cmp al, 0
        je quit_all
        cmp al, "-"
        jne not_neg
            mov byte[is_neg], 1
            lodsb
        not_neg:
        
        sub al, 48
        mov bl, al
        lodsb
        cmp al, ","
        je skip
        cmp al, 0
        je quit
        
        mov [cif], al
        mov al, bl
        mov byte[mult], 10
        mul byte[mult]
        mov bl, al
        sub byte[cif], 48
        add bl, [cif]
        lodsb
        cmp al, ","
        je skip
        cmp al, 0
        je quit
        
        mov [cif], al
        mov al, bl
        mov byte[mult], 10
        mul byte[mult]
        mov bl, al
        sub byte[cif], 48
        add bl, [cif]
        
        skip:
        mov al, bl
        cmp byte [is_neg], 1
        jne not_neg1
            call negate_al
            mov byte[is_neg], 0
        not_neg1:
        stosb
        skip_all:
        jmp split_str
        
    
    quit:
    mov al, bl
    cmp byte [is_neg], 1
    jne not_neg2
        call negate_al
        mov byte[is_neg], 0
    not_neg2:
    stosb
    quit_all:
	push 0
	call [exit]

