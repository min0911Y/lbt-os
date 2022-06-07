;filename:mul.inc
;date:2021103
Kmul:
;入口参数:ax 第一个乘数 bx 第二个乘数
;出口参数:ax 积
mov cx,bx
sub cx,1
mov dx,ax
Kmul_start:
add ax,dx
loop Kmul_start
Kmul_over:
ret