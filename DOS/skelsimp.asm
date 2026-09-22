;-------------------------------------------------------------------------------
;   PAGE [length][,width].
;       Defaults to 50, 80. With no operand forces a page to eject at specific 
;       line.
;-------------------------------------------------------------------------------
    page 60, 132

;-------------------------------------------------------------------------------
;   TITLE text    comment
;-------------------------------------------------------------------------------
TITLE   SKELETON (EXE)   ASM simplified skeleton

;-------------------------------------------------------------------------------
;   .MODEL  [memory-model]
;       Automaticaly generates required ASSUME statement.
;       TINY: for .COM programs with data, code and stack in one 64K segment.
;       SMALL: One code and one data segments. All are near by default.
;       MEDIUM: More than one code segment and single data segment.
;       COMPACT: Single code segment and multiple data segments.
;       LARGE: Multiple code and data segments.
;       FLAT: non-segmented configuration available in 32-bit operating systems.
;             Similar to tiny model in that all code and data go in a single
;             32-bit -addressable block of memory. To write a flat model program
;             specify the .386 or .486 directive before .MODEL FLAT
;-------------------------------------------------------------------------------
    .MODEL  SMALL

;-------------------------------------------------------------------------------
;   .STACK  [size (bytes)]
;-------------------------------------------------------------------------------
    .STACK  64
    
;-------------------------------------------------------------------------------    
;   .DATA - data segment. Default name: _DATA
;-------------------------------------------------------------------------------
    .DATA

;-------------------------------------------------------------------------------    
;   .CODE [name] - code segment. Default name: _TEXT
;-------------------------------------------------------------------------------
    .CODE
MAIN    PROC    FAR
    MOV AX, @data       ; Set address of data segment in DS
    MOV DS, AX
;
; code here
;
    MOV AX, 4C00H       ; Exit with code 0. Same as:
                        ; MOV AH, 4CH
                        ; MOV AL, returncode
    INT 21H
MAIN    ENDP    
    END MAIN