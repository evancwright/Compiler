
; machine generate Z80 routine from XML file
*MOD
jump_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; println("WHEEE!")
	push af
	push ix
	ld ix,string_table
	ld b,54 ; WHEEE!
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

