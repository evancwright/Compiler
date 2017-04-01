;main file for trs-80 shell
 

QINPUT equ 1bb3h
CRTBYTE equ  0033H
INBUF equ 41e8h
CLS equ 01c9h
OUTLIN equ 28a7h		; src str in HL/

	; #include "WeclomeZ80.asm"

;header DB 01h,02h,00h,50h ; header for MAME testing (remove later)
;START  
	ORG 5000H

main
loop
		call CLS
$inp?	call QINPUT
		call parse
		jp $inp?
		ret
	
testtab
		ld b,2d
$inp1?	push bc
		call QINPUT
		pop bc
		;ld ix, string_table
		;call print_table_entry
		ld a,b
		call print_obj_name
		call printcr
		inc b
		jp $inp1?
	
	
*INCLUDE parser.asm
*INCLUDE print_rets.asm
*INCLUDE strings.asm
*INCLUDE PrepTableZ80.asm
*INCLUDE tables.asm
*INCLUDE StringTableZ80.asm
*INCLUDE DictionaryZ80.asm
*INCLUDE VerbTableZ80.asm
*INCLUDE ObjectWordTableZ80.asm
	END 5000H
END