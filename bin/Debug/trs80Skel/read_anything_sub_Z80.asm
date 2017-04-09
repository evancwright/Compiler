
; machine generate Z80 routine from XML file
*MOD
read_anything_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; println("THERE IS NOTHING TO READ ON THAT.")
	push af
	push ix
	ld ix,string_table
	ld b,64 ; THERE IS NOTHING TO READ ON THAT.
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

