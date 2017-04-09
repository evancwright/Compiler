
; machine generate Z80 routine from XML file
*MOD
yell_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; println("AAAAAAAAAAAAARRRRGGGGGG!")
	push af
	push ix
	ld ix,string_table
	ld b,53 ; AAAAAAAAAAAAARRRRGGGGGG!
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

