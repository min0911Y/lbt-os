shutdown:
;Connect to APM API
MOV     AX,5301H
XOR     BX,BX
INT     15H

;Try to set APM version (to 1.2)
MOV     AX,530EH
XOR     BX,BX
MOV     CX,0102H
INT     15

;Turn off the system
MOV     AX,5307H
MOV     BX,0001H
MOV     CX,0003H
INT     15H

;Exit (for good measure and in case of failure)
RET