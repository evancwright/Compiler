
; machine generate Z80 routine from XML file
*MOD
kill_self_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; println("IF YOU ARE EXPERIENCING SUICIDAL THOUGHTS, YOU SHOULD SEEK PHSYCIATRIC HELP.")
	push af
	push ix
	ld ix,string_table
	ld b,47 ; IF YOU ARE EXPERIENCING SUICIDAL THOUGHTS, YOU SHOULD SEEK PHSYCIATRIC HELP.
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

