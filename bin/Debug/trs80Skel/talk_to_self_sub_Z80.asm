
; machine generate Z80 routine from XML file
*MOD
talk_to_self_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; println("TALKING TO YOURSELF IS A SIGN OF IMPENDING MENTAL COLLAPSE.")
	push af
	push ix
	ld ix,string_table
	ld b,51 ; TALKING TO YOURSELF IS A SIGN OF IMPENDING MENTAL COLLAPSE.
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

