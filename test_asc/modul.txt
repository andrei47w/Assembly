bits 32                         
segment code use32 public code
global negate_al

negate_al:
	
    mov bl, al
    sub al, bl
    sub al, bl
    
	ret