;main file for trs-80 shell
 
*INCLUDE objdefsZ80.asm
 
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
		ld hl,welcome ; print welcome,author,version
		call OUTLIN
		call printcr
		ld hl,author
		call OUTLIN
		call printcr
		ld hl,version
		call OUTLIN
		call printcr
		call look_sub
$inp?	call QINPUT
		call parse
		ld a,(sentence)
		cp 0
		jp z,$inp?
		call encode
		call run_sentence
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
		ret
	
*INCLUDE parser.asm
*INCLUDE look.asm
*INCLUDE tables.asm
*INCLUDE strings.asm
*INCLUDE checksZ80.asm
*INCLUDE sentencesZ80.asm
*INCLUDE movementZ80.asm
*INCLUDE containersZ80.asm
*INCLUDE routinesZ80.asm
*INCLUDE inventoryZ80.asm
*INCLUDE miscZ80.asm
*INCLUDE print_rets.asm
*INCLUDE EventsZ80.asm
*INCLUDE articlesZ80.asm
*INCLUDE PrepTableZ80.asm
*INCLUDE StringTableZ80.asm
*INCLUDE DictionaryZ80.asm
*INCLUDE VerbTableZ80.asm
*INCLUDE ObjectTableZ80.asm
*INCLUDE ObjectWordTableZ80.asm
*INCLUDE BackDropTableZ80.asm
*INCLUDE before_table_Z80.asm
*INCLUDE instead_table_Z80.asm
*INCLUDE after_table_Z80.asm
*INCLUDE CheckRulesZ80.asm
*INCLUDE sentence_tableZ80.asm
*INCLUDE WelcomeZ80.asm
*INCLUDE UserVarsZ80.asm
score DB 0
	END 5000H
END