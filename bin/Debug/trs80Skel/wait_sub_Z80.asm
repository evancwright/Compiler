
; machine generate Z80 routine from XML file
*MOD
wait_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; println("TIME PASSES...")
	push af
	push ix
	ld ix,string_table
	ld b,54 ; TIME PASSES...
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

