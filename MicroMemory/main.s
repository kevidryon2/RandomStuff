global _start

section .data
	clearscreen: db 0x1b, "[2J"
	clearscreen_len: equ $ - clearscreen

	curshome: db 0x1b, "[H"
	curshome_len: equ $ - curshome

	
	
	time: dd 0x0
	
section .text
_start:
	mov eax, 4 ;write
	mov ebx, 0 ;stdout
	mov ecx, clearscreen ;message
	mov edx, clearscreen_len ;length
	int 0x80
	
	mov eax, 4 ;write
	mov ebx, 0 ;stdout
	mov ecx, curshome ;message
	mov edx, curshome_len ;length
	int 0x80

	
	
	;delay one second
	mov eax, 1
	call delay
	
	;exit program
	mov eax, 1 ;exit
	mov ebx, 0 ;success
	int 0x80

;delay in eax (unix seconds)
;alarm version
delay:
    ;save eax for later
    push eax
    
    ;set alarm signal handler
    mov eax, 48 ;signal
    mov ebx, 14 ;alarm
    mov ecx, .return ;return
    int 0x80 ;syscall
    
    ;save previous alarm signal handler
    mov edx, eax
    
    ;set alarm
    mov eax, 27 ;alarm
    pop ebx ;restore delay in ebx
    int 0x80 ;syscall
    
    ;wait for alarm
    mov eax, 29 ;pause
    int 0x80 ;syscall
    
.return:
    ;restore previous alarm handler
    mov eax, 48 ;signal
    mov ebx, 14 ;alarm
    mov ecx, edx ;previous handler
    int 0x80 ;syscall

    ret
