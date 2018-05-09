SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1

segment .data
	msg1 db "Ingresa el numero", 0xA,0xD
	len1 equ $- msg1
	msg2 db " ", 
	len2 equ $- msg2
	msg3 db "",0xA,0xD 
	len3 equ $- msg3
	
segment .bss
	num1 resb 2

section  .text
	global _start  
_start:  

	mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, msg1
	mov edx, len1
	int 0x80

	mov eax, SYS_LEE
	mov ebx, STDIN
	mov ecx, num1
	mov edx, 1
	int 0x80

	mov di,2
	
ciclo:
	mov ax, [num1]
	mov bx,2
    div bx

    cmp dx,0
    je par

    ;impar:
    	mov eax,[num1]
    	mov ebx,3
    	sub eax,'0'

    	mul ebx ;eax=eax*3
    	add eax,1 ;eax++
    	add eax,'0'
    	mov [num1],eax

    	mov eax, SYS_PRINT
		mov ebx, STDOUT
		mov ecx, num1
		mov edx, 1
		int 0x80
		mov eax, SYS_PRINT
		mov ebx, STDOUT
		mov ecx, msg2
		mov edx, len2
		int 0x80
		jmp salto
	par:
		mov eax,[num1]
		mov ebx,2
		sub eax,'0'
		
		div ebx   ;eax=eax/2
		add eax,'0'
		mov [num1],eax

		mov eax, SYS_PRINT
		mov ebx, STDOUT
		mov ecx, num1
		mov edx, 1
		int 0x80
		mov eax, SYS_PRINT
		mov ebx, STDOUT
		mov ecx, msg2
		mov edx, len2
		int 0x80
		jmp salto
		
salto:
mov eax,[num1]
sub eax,'0'
cmp eax, 1
ja ciclo

salir:
	mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, msg3
	mov edx, len3
	int 0x80

    mov eax, SYS_SALIDA
	;xor ebx, ebx
	int 0x80