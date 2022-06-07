;file:string.inc
;date: 2021103
stringTOint: ;储存到ax寄存器 si为地址 以问号结尾
mov ax,0
switch_start:
mov dl,[si]
cmp dl,'$'
je over_switch
mov dx,ax
mov cx,9
s:
add ax,dx
loop s
mov dx,0
mov dl,[si]
sub dl,30h
add ax,dx
inc si
jmp switch_start
over_switch:
ret

int_to_string:;数字：AX 字符串指针地址 si
mov bx,si
push ax
call get_str_length ;di=length
pop ax
sub di,1
mov cx,si
add si,di
int_to_string_start:
mov dx,10
cmp ax,dx
jl l_10
;------------
mov cx,ax
mov dx,10
call Kdiv
;------------


add bx,0x30
mov [si],bl
sub si,1
jmp int_to_string_start
l_10:
add ax,0x30
mov [si],al
dtc_over:
ret

get_str_length:
mov di,0
get_str_length_start:;指令以$结尾 bx为字符串的地址
mov al,'$'
cmp [bx+di],al
je get_str_length_over
inc di
jmp get_str_length_start
get_str_length_over:
ret
%include "div.inc"
%include "mul.inc"