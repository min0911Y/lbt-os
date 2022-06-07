;filename:div.inc
;date:20211101
;by min0911_
Kdiv:
;入口参数 被除数cx 除数dx 出口参数：商ax 余数bx    si
Kdiv_init:
push si
mov si,cx
mov ax,0
Kdiv_start:
cmp dx,cx
jg Kdiv_Over_smail_0
cmp cx,0
je Kdiv_Over_dy_0
sub cx,dx
cmp cx,0
je Kdiv_Over_dy_0
inc ax
jmp Kdiv_start
Kdiv_Over_smail_0:
mov cx,dx
sub cx,1
mov dx,ax
s_mul:
add dx,ax
loop s_mul
sub si,dx
mov bx,si
pop si
ret
Kdiv_Over_dy_0:
inc ax
mov bx,0
pop si
ret