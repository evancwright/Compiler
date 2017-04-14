
; machine generate Z80 routine from XML file
*MOD
unlock_tardis_with_sonicscrewdriver_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	push af
	push bc
	ld a,3; tardis
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,PROPERTY_BYTE_1 ; get prop byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	bit 7,(ix) ; test locked prop bit
	jp z,$a?
	nop ; println("AFTER SOME CLICKS AND BUZZES, THE TARDIS POPS OPEN.")
	push af
	push ix
	ld ix,string_table
	ld b,70 ; AFTER SOME CLICKS AND BUZZES, THE TARDIS POPS OPEN.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; tardis.open = 1
	push af
	push bc
	ld a,3; tardis
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
	nop ; tardis.locked=0
	push af
	push bc
	ld a,3; tardis
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
	nop ; tardis.lockable=0
	push af
	push bc
	ld a,3; tardis
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,PROPERTY_BYTE_1 ; get prop byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	res 6,(ix) ; clr lockable bit
	jp $b? ; skip else 
$a?	nop ; close (tardis.locked==1)
	nop ; println("THE TARDIS IS ALREADY OPEN.")
	push af
	push ix
	ld ix,string_table
	ld b,71 ; THE TARDIS IS ALREADY OPEN.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
$b?	nop ; end else
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

