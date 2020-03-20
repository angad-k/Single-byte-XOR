section .bss
	string resb 100
	key resb 1
section .text
	global _start
_start:
	;code for taking string input
	mov eax, 3 ;SYS_READ(System call)
	mov ebx, 2 ;stdin argument for the call
	mov ecx, string ;Passsing address of string to ecx
	mov edx, 100 ;length of the string
	int 80h ;We call the interrupt no. 0x80 which is used to make system calls to kernel

	;code for taking key input
        mov eax, 3 ;SYS_READ(System call)
        mov ebx, 2 ;stdin argument for the call
        mov ecx, key ;Passing address of key variable to ecx
        mov edx, 1 ;length of the key
        int 80h ;We call the interrupt no. 0x80 which is used to make system calls to kernel

	mov BX, [key] ;passing parameter
	call exor ;calling procedure

	;Output the string
	mov eax, 4 ;SYS_WRITE(System Call)
	mov ebx, 1 ;stdout argument for the call
	mov ecx, string ;Passing address of the XORd string to ecx register
	mov edx, 100 ;Length of the string
	int 80h ;We call the interrupt no. 0x80 which is used to make system calls to kernel

	;exit program
	mov eax, 1 ;SYS_EXIT(System Call)
	int 80h ;We call the interrupt no. 0x80 which is used to make system calls to kernel


exor:
	;code for XOR
        mov edx, 0 ;We are using edx as the counter. Here we initialize it to 0.
        .loop:
        cmp byte [string + edx], 0xA ;Checking for newline character.
        JE .next ;Exiting loop if current character is newline.
        mov AX, [string + edx] ;Moving the character stored in the memory location pointed by string plus the value in edx to AX register.
        xor AX, BX ;XORing character stored in BX with AX. ie - String's  character with the key.
        mov [string + edx], AX ;Moving contents of AX to the memory location pointed by string plus the value in edx
        INC edx ;Counter++
        JMP .loop ;Next iteration.
        .next:
	ret ;Ghar-wapsi
