
; machine generate Z80 routine from XML file
*MOD
unlock_door_with_key_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; println("THE DOOR IS NOW UNLOCKED")
	push af
	push ix
	ld ix,string_table
	ld b,80 ; THE DOOR IS NOW UNLOCKED
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; 29.open = 1
	push af
	push bc
	ld a,29; 29
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,PROPERTY_BYTE_1 ; get prop byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	set 5,(ix) ; set the open bit
	nop ; 29.locked = 0
	push af
	push bc
	ld a,29; 29
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,PROPERTY_BYTE_1 ; get prop byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	res 7,(ix) ; clr locked bit
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

