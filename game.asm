section	.text
   global _start     ;must be declared for linker (ld)
	
_start:	            ;tells linker entry point

   ;(in the future)generates a pseudo-random number between 0 and 9
   ;xor eax,eax;
   ;move 50,eax;
   ;mov [goal],50;
   ;xor eax,eax;
   
   
   ;presents initial message
   add	edx,len1     ;message length
   mov	ecx,msginit     ;message to write
   mov	ebx,1       ;file descriptor (stdout)
   mov	eax,4       ;system call number (sys_write)
   int	0x80        ;call kernel

   jmp	_read;
   int  0x80

_read: ;insert player guess
   mov  eax,3		;sys_read. Read what user inputs
   mov  ebx,0		;From stdin
   mov  ecx,guess	;Save user input to buffer.
   int  0x80;

   jmp  _evaluate;
   int  0x80;


_evaluate: ; compare player's entry with the goal value
   ;cmp byte  ecx,goal;
   mov    al, [ ecx ]
   mov    ah, [ goal ]
   cmp    al, ah
   je   _win;	if equal jump to _win
   
   ;dec  count;
   ;cmp  count,1;
   ;jl   _loose;

   jmp  _loose; _evaluate;
   int  0x80;


;_count: ; count the remaining number of play turns

_win: ; final function if the game was won
   mov  edx,len2    ;message length
   mov  ecx,win     ;message to write
   mov  ebx,1       ;file descriptor (stdout)
   mov  eax,4       ;system call number (sys_write)
   int  0x80        ;call kernel


   mov eax,1;   system call number (sys_exit)
   int 0x80;

_loose: ; final function if the game was lost
   mov  edx,len4    ;message length
   mov  ecx,loose   ;message to write
   mov  ebx,1       ;file descriptor (stdout)
   mov  eax,4       ;system call number (sys_write)
   int  0x80        ;call kernel

   mov eax,1;   system call number (sys_exit)
   int 0x80;



section .bss
guess resb 256;
;goal resb 256;



section	.data
msginit db 'Guess the number', 0xa  ;string to be printed
len1 equ $ - msginit     ;length of the string

 
win db '====Correct====', 0xa ;
len2 equ $ - win;

incor db 'Incorrect! try again...', 0xa ;
len3 equ $ - incor;

loose db '----better luck next time----', 0xa ; 
len4 equ $ - loose;

count equ 5;

goal db 48+5; 48 is the ascii symbol '0', 45 + 5 = 5
