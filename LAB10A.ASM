; PROGRAM  :: FIND OUT WHETHER A GIVEN SUBSTRING IS PRESENT IN A MAIN STRING
; OF CHARACTERS

.MODEL SMALL

DISPLAY MACRO MSG
        LEA DX, MSG
        MOV AH, 09H
        INT 21H
ENDM

.DATA
MSG1 DB 0DH, 0AH, "ENTER STRING    :: $"
MSG2 DB 0DH, 0AH, "ENTER SUBSTRING :: $"
STR DB 80H DUP(?)
STR1 DB 80H DUP(?)
MSG3 DB 0DH, 0AH, "---SUBSTRING FOUND---$"
MSG4 DB 0DH, 0AH, "---SUBSTRING NOT FOUND---$"


.CODE
START : MOV AX, @DATA
        MOV DS, AX
        XOR CX, CX
        DISPLAY MSG1
        MOV SI, OFFSET STR
AGAIN:  MOV AH, 01H
        INT 21H
        CMP AL, 0DH
        JE NEXT
        MOV [SI], AL
        INC SI
        INC CL                  ; STORES THE LENGTH FOR STRING
        JMP AGAIN
NEXT :  MOV [SI], BYTE PTR '$'
        DISPLAY MSG2
        MOV SI, OFFSET STR1
AGAIN1: MOV AH, 01H
        INT 21H
        CMP AL, 0DH
        JE NEXT1
        MOV [SI], AL
        INC SI
        INC CH                  ; STORES THE LENGTH FOR SUBSTRING
        JMP AGAIN1
NEXT1 : MOV [SI], BYTE PTR '$'
        MOV SI, OFFSET STR
N1 :    CALL CHECK
        JNC SUCCESS
        INC SI
        DEC CL
        JNZ N1
        JMP FAIL
SUCCESS: DISPLAY MSG3
        JMP FINAL
FAIL : DISPLAY MSG4
       JMP FINAL

CHECK PROC NEAR
        PUSH CX
        PUSH SI
        CMP CL, CH
        JC ERR
        MOV BH, CL              ; FOR STRING
        MOV BL, CH              ; FOR SUBSTRING
        MOV DI, OFFSET STR1
AG:     MOV AL, [DI]
        CMP AL, [SI]
        JNE ERR
        INC SI
        INC DI
        DEC BH
        DEC BL
        JNZ AG
        CLC
        JMP OVER
ERR  :  STC                     ; SET CARRY IF NOT FOUND...
OVER:   POP SI
        POP CX
RET
CHECK ENDP

FINAL : MOV AH, 4CH
        INT 21H
END START
