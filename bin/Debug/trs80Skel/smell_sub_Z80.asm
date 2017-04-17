
; machine generate Z80 routine from XML file
*MOD
smell_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; println("YOU SMELL NOTHING UNEXPECTED.")
	push af
	push ix
	ld ix,string_table
	ld b,53 ; YOU SMELL NOTHING UNEXPECTED.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

