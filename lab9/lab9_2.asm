bits 32
global _negate

segment data public data use32

segment code public code use32

_negate:

    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]        
    
    sub eax, [ebp + 8]         
    sub eax, [ebp + 8]         

    mov esp, ebp
    pop ebp

    ret
