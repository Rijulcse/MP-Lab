; PROGRAM :: READ A PAIR OF INPUT CO-ORDINATES IN BCD AND MOVE THE CURSOR
; TO THE SPECIFIED LOCATION ON THE SCREEN

; RESTERICTION :: PLEASE ENTER THE ROW AND COLUMN IN TWO DIGITS
; AS 00 OR 34

.MODEL SMALL

DISPLAY MACRO MSG
        LEA DX, MSG
        MOV AH, 09H
        INT 21H
ENDM

.DATA
ROW DB 02H DUP(?)
COLUMN DB 02H DUP(?)
MSG1 DB 0DH, 0AH, "ENTER THE X CO-ORDINATE (ROW)    :: $"
MSG2 DB 0DH, 0AH, "ENTER THE Y CO-ORDINATE (COLUMN) :: $"

.CODE
START : MOV AX, @DATA
        MOV DS, AX
        DISPLAY MSG1
        MOV SI, OFFSET ROW
        CALL READ               
        DISPLAY MSG2
        MOV SI, OFFSET COLUMN
        CALL READ
        MOV SI, OFFSET ROW
        MOV AH, [SI]
        INC SI
        MOV AL, [SI]
        SUB AX, 3030H
        AAD
        MOV DH, AL
        MOV SI, OFFSET COLUMN
        MOV AH, [SI]
        INC SI
        MOV AL, [SI]
        SUB AX, 3030H
        AAD
        MOV DL, AL
        MOV AH, 00H
        MOV AL, 03H
        INT 10H
        MOV AH, 02H
        INT 10H
        JMP FINAL
READ PROC NEAR
        MOV CX, 02H
BACK:   MOV AH, 01H
        INT 21H
        MOV [SI], AL
        INC SI
        DEC CX
        JNZ BACK
RET
READ ENDP
FINAL : MOV AH, 01H
        INT 21H
        MOV AH, 4CH
        INT 21H
END START


