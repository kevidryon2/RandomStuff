org 0x80000000
BITS 32

_start:
	mov eax, 0x0
.loop:
	inc eax
	push eax
	
	;generate random number in ecx and ebx
	add eax, eax
	add ebx, eax
	mul ebx
	mov ecx, eax
	
	;generate random number in edx and ecx
	add eax, eax
	add ecx, eax
	mul ecx
	mov edx, eax
	
	pop eax
	ret
