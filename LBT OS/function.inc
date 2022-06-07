printf:
mov si,dx
mov al,[si]
cmp al,'$'
je function_PRINTF_OVER
mov ah,0EH
int 10H
inc dx
jmp printf
function_PRINTF_OVER:
ret

put_number:
mov si,dx
mov al,[si]
cmp al,'$'
je function_put_number_OVER
cmp al,0
je PUT_0
mov ah,0EH
int 10H
inc dx
jmp printf
PUT_0:
inc dx
jmp put_number
function_put_number_OVER:
ret


com_cmp:
;入口参数：
;bx 需要比较的命令(以问号结尾)
;si 另一个比较的字符串
;出口参数
;cx = 1 为 true cx = 0 为flase
mov di,0
get_length:;指令以问号结尾
mov al,'?'
cmp [bx+di],al
je get_over
inc di
jmp get_length
get_over:
mov cx,di
mov di,0
start_if_com:
;mov bx,com
mov al,[bx+di]
cmp [si],al
;pop ax
jne flase_jmp
inc di
inc si
loop start_if_com
mov cx,1
ret
flase_jmp:
mov cx,0
ret
input: ;输入函数bx为字符串的地址
call get_str_length
mov cx,di
mov di,si
mov di,0
input_start:
mov ax,0
int 0x16
cmp al,8
je backspace
cmp al,0dh
je INPUT_OVER
cmp cx,0
je input_start
mov [bx+di],al
mov ah,0eh
int 0x10
sub cx,1
inc di
jmp input_start
INPUT_OVER:
call endl
ret

endl:
mov ah,0x0e
mov al,13
int 0x10
mov al,10
int 0x10
ret
backspace:
cmp di,0
je backspace_over
sub di,1
inc cx
mov ah,0x0e
mov al,8
int 0x10
mov al,' '
int 0x10
mov al,8
int 0x10
mov al,'?'
mov [bx+di],al
jmp input_start
backspace_over:
jmp input_start
pause_text: db 'Press any key to continue . . .$'
pause_Show:
	mov dx,pause_text
	call printf
	mov ax,0
	int 0x16
	ret


%include "string.inc"