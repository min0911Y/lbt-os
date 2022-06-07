jmp main
msg: db 'this is printf function!$'
input_s: db '??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????$'
input_tips: db 'kardow OS -> $'
bad_command: db 'Bad Command$'
clear_command: db 'clear?'
pause_command: db 'PAUSE?'
a_com: db 'test?'
welcome_msg_shell: db '[SYSMSG]         System is started!           ',13,10,'[SYSMSG]         Kardow OS 0.5 On 8086 PC',13,10,'$'
test_string: db '97?'
int_to: db 0,0,0,0,0,0,'$'
test_div_command: db 'test_div?'
test_dtc_command: db 'test_dtc?'
GUESSGAME_command: db 'guessgame?'
poweroff_com: db 'poweroff?'
main:
	mov ax,800h
	mov ds,ax
	mov es,ax
	mov ax,0003
	int 0x10
	call welcome_ui
	mov dx,welcome_msg_shell
	call printf
	jmp shell
	jmp $
welcome_msg: db 13,10,13,10,13,10,13,10,13,10,13,10,'        kardow OS ON 8086 PC. ',13,10,'        Appler and min0911_ All rights reserved',13,10,'        System Version 0.1. shell version 0.1.',13,10,'        $'
welcome_ui:
mov dx,welcome_msg
call printf
call pause_Show
mov ax,0003
int 0x10
ret


shell:



mov dx,input_tips
call printf
mov bx,input_s
call input

mov si,input_s
mov bx,test_div_command
call com_cmp
cmp cx,1
je test_div

mov si,input_s
mov bx,test_dtc_command
call com_cmp
cmp cx,1
je test_dtc

mov si,input_s
mov bx,a_com
call com_cmp
cmp cx,1
je test_command

mov si,input_s
mov bx,clear_command
call com_cmp
cmp cx,1
je clear

mov si,input_s
mov bx,pause_command
call com_cmp
cmp cx,1
je pause_com_Show

mov si,input_s
mov bx,GUESSGAME_command
call com_cmp
cmp cx,1
je GUESSGAME

mov si,input_s
mov bx,poweroff_com
call com_cmp
cmp cx,1
je poweroff

mov al,'?'
cmp [input_s],al
je shell

jmp bad_command_Show
jmp shell

poweroff:
call shutdown
jmp shell
pause_com_Show:
	call pause_Show
	call endl
	jmp shell
clean:
mov bx,input_s
call get_str_length
mov cx,di
mov di,0
clean_Start:
cmp di,cx
je clean_Over
mov al,'?'
mov [input_s+di],al
inc di
jmp clean_Start
clean_Over:
ret
bad_command_Show:
mov dx,bad_command
call printf
call endl
call clean
jmp shell
clear:
mov ax,0003H
int 0x10
call clean
mov al,'?'
mov [input_s],al
jmp shell
test_command_String: db 'this is TEST COMMAND! if you look this message,then com_cmp function is no bug!$'
test_command:
mov dx,test_command_String
call printf
call endl
call clean
jmp shell
test_ok: db 'RIGHT!$'
test_div:
mov cx,10
mov dx,5
call Kdiv
cmp ax,2
je setup2
setup2:
mov cx,97
mov dx,10
call Kdiv
cmp bx,7
je RIGHT_OUT
RIGHT_OUT:
mov dx,test_ok
call printf
call endl
call clean
jmp shell
test_dtc:
mov ax,54
mov si,int_to
call int_to_string
mov dx,int_to
call put_number
call endl
call clean
jmp shell

GUESS_STR: db 0,0,0,0,0,'$'
GUESSGAME_MSG1: db 'IT IS TOO BIG!$'
GUESSGAME_MSG2: db 'IT IS TOO SMAIL!$'
GUESSGAME_MSG3: db 'YOU ARE RIGHT!$'
GUESSGAME_S: db 'GUESSGAME V0.1.$'
GUESSGAME_tipS: db 'Please GUESS:$'
RAND_PROC:
PUSH CX
PUSH DX
PUSH AX
STI
MOV AH,0             ;读时钟计数器值
INT 1AH
MOV AX,DX            ;清高6位
AND AH,3
MOV DL,101           
DIV DL
MOV BL,AH            ;余数存BX，作随机数
POP AX
POP DX
POP CX
RET
GUESSGAME:
call RAND_PROC
mov dx,GUESSGAME_S
call printf
call endl
GUESSGAME_start:
mov dx,GUESSGAME_tipS
call printf
push bx
mov bx,GUESS_STR
call input
mov si,GUESS_STR
call stringTOint
mov si,GUESS_STR
pop bx
cmp ax,bx
je E_num
jg big
jl smail
jmp GUESSGAME_start
smail:
mov dx,GUESSGAME_MSG2
call printf
call endl
jmp GUESSGAME_start
big:
mov dx,GUESSGAME_MSG1
call printf
call endl
jmp GUESSGAME_start
E_num:
mov dx,GUESSGAME_MSG3
call printf
call endl
call clean
jmp shell


%include "shutdown.asm"
%include "function.inc"