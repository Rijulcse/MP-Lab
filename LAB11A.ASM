; PROGRAM :: GENERATE THE FIRST 'N' FIBONACCI NUMBERS

.MODEL SMALL

.DATA
N DB 0AH
RES DB 010H DUP(?)
FIB1 EQU 00H
FIB2 EQU 01H

.CODE
START : MOV AX, @DATA
        MOV DS, AX
        MOV CL, N
        XOR BX, BX
        MOV SI, OFFSET RES
        CMP CL, 01H
        JE SINGLE                   
        CMP CL, 02H
        JE DOUBLE
        SUB CL, 02H
        JMP ALL
SINGLE :MOV [SI], BYTE PTR FIB1
        INC BL
        JMP FINAL
DOUBLE :MOV [SI], BYTE PTR FIB1
        INC BL
        INC SI
        MOV [SI], BYTE PTR FIB2
        INC BL
        JMP FINAL
ALL :   MOV [SI], BYTE PTR FIB1
        INC SI
        MOV [SI], BYTE PTR FIB2
        INC SI
        MOV AL, FIB1
        MOV AH, FIB2
AG:     MOV BH, AL
        ADD BH, AH
        PUSH AX
        MOV AL, BH
        MOV [SI], AL
        POP AX
        MOV AL, AH
        MOV AH, BH
        INC SI
        DEC CL
        JNZ AG
FINAL : MOV AH, 4CH
        INT 21H
END START

        
        

