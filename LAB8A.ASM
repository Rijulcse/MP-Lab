; PROGRAM :: COMPUTE THE FACTORIAL OF A POSITIVE INTEGER 'n' USING
; RECURSIVE PROCEDURE....

.MODEL SMALL

.DATA
NUM EQU 05H
RES DW 01H DUP(?)

.CODE
START : MOV AX, @DATA
        MOV DS, AX
        MOV CL, NUM
        XOR AX, AX
        XOR BX, BX
        CALL FACT
        MOV [RES], AX
        MOV AH, 4CH
        INT 21H

FACT PROC NEAR
        CMP CL, 00H
        JE FINAL
        PUSH CX
        DEC CL
        CALL FACT
        POP CX
        MUL CL
        RET
FINAL : ADD AX, 01H
RET
FACT ENDP

END START
